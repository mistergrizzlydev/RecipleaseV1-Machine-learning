//
//  RecognizerVC.swift
//  RecipleaseV1
//
//  Created by VINCENT BOULANGER on 27/02/2019.
//  Copyright © 2019 VBoulanger. All rights reserved.
//


import UIKit
import AVFoundation
import Vision

class RecognizerVC: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {
	
	@IBOutlet weak var ui_Label: UILabel!
	
	@IBOutlet weak var ui_proba: UILabel!
	
	let captureSession = AVCaptureSession()
	lazy var imageRecognizerRequest: VNRequest = { // propriété calculé de type lazy, chargée uniquement lorsuqe la variable est appelée et réutilisée par la suite sans être de nouveau chargée
		let model = try! VNCoreMLModel(for: Inceptionv3().model) // on charge le fichier datamodel squeezie
		let request = VNCoreMLRequest(model: model, completionHandler: self.imageRecognizerHandler) // il charge le model et lance le completion handler de la fonction ci dessous
		return request
	}()
	func imageRecognizerHandler(request:VNRequest, error: Error?) {
		// si je n'ai pas les bonnes observations au bon format et si il n'y a pas un élément à l'intérieur(best  guesss.first)
		guard let observations = request.results as? [VNClassificationObservation], let bestGuess = observations.first else {return}
		// Vision utilise le thread sur lequel il est programmé
		DispatchQueue.main.async { // le code utilisé ici ne sera fait que sur le thread graphique pendant que la capture tourne en tache de fond
			if bestGuess.confidence > 0.6 {
				self.ui_Label.text = bestGuess.identifier
				self.ui_proba.text = "Probabilité: \(bestGuess.confidence)"
			} else {
				self.ui_proba.text = "Recherche en cours..."
			}
		}
	}
	@IBOutlet weak var recognizerView: UIView!
	
	@IBAction func startSession(_ sender: UIButton) {
		if captureSession.isRunning {
			captureSession.stopRunning()
		} else {
			if captureSession.inputs.count == 0 {
				configureCaptureSession()
			}
			// 4 démarrer la session
			captureSession.startRunning()
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()

	}
	override func viewWillAppear(_ animated: Bool) {
		
	}
	func configureCaptureSession() {
	// 1 - configurer les entrées, le flux entrant
		if let camera = AVCaptureDevice.default(for: AVMediaType.video), // start camera, continue si la caméra a été trouvée.
			let cameraFeed = try? AVCaptureDeviceInput(device: camera) { // flux d'entrée
				captureSession.addInput(cameraFeed) // je capture le flux d'entrée et je l'envoie à la session
			// ajouter une autorisation
			// 2 - configurer les sorties
			let outputFeed = AVCaptureVideoDataOutput()
			outputFeed.setSampleBufferDelegate(self, queue: DispatchQueue.global(qos: DispatchQoS.QoSClass.userInitiated)) // dispatch queue: user initiated lance un dispatch queue à l'uinitiative de l'utilisateur
			captureSession.addOutput(outputFeed)
			// 3 - configurer l'aperçu
			let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
			previewLayer.frame = recognizerView.bounds
			recognizerView.layer.addSublayer(previewLayer)
			
		}
		
	
	}
	func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) { // sample buffer contient les datas.
		guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {return}
		let imageRequestHandler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, orientation: CGImagePropertyOrientation.up, options: [:])
		do {
			try imageRequestHandler.perform([imageRecognizerRequest])
		} catch {
			print(error)
		}
	}
	func captureOutput(_ output: AVCaptureOutput, didDrop sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) { // quand le processeur est surchargé. Il perd des frames. Permet de prévenir l'utiliosateur qu'il y a un ralentissement
		
	}
}
