//
//  RecipeViewController.swift
//  RecipleaseV1
//
//  Created by VINCENT BOULANGER on 07/02/2019.
//  Copyright © 2019 VBoulanger. All rights reserved.
//

import UIKit

class RecipeVC: UIViewController {
	@IBOutlet weak var backViewRateAndTime: UIView!
	@IBOutlet weak var imageRecipe: UIImageView!
	@IBOutlet weak var rateLabel: UILabel!
	@IBOutlet weak var timeLabel: UILabel!
	@IBOutlet weak var recipeName: UILabel!
	@IBOutlet weak var ingredientsTableView: UITableView!
	@IBOutlet weak var getDirections: UIButton!
	
	@IBOutlet weak var favoriteButtonAction: UIBarButtonItem!
	@IBOutlet weak var favoriteButton: UIBarButtonItem!
	
	
	var matches: [Match]!
	var recipeDetailAPIResult: [RecipeDetailAPIResult]!
	// launch URL
	@IBAction func getRecipeDirection(_ sender: UIButton) {
		
		guard let url = URL(string: "https://openclassrooms.com/fr") else { return }
		UIApplication.shared.open(url)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		print("viewDidLoad Reciple detail ")

	//	print("data recipe : \(recipeDetailAPIResult[0].id)")
		self.navigationItem.title = "Reciplease"
		designButton()
		ingredientsTableView.dataSource = self
		ingredientsTableView.reloadData()
		}
	override func viewWillAppear(_ animated: Bool) {
		ingredientsTableView.reloadData()
	}
	func designButton() {
		backViewRateAndTime.layer.cornerRadius = 5
		getDirections.layer.cornerRadius = 5
	}
}

extension RecipeVC: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		guard let recipeDetailAPIResult = recipeDetailAPIResult else {return 0}
		
		return recipeDetailAPIResult.count
	}
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientDetailCell", for: indexPath)
		recipeName.text =  String(recipeDetailAPIResult[indexPath.row].name)
		if recipeDetailAPIResult!.count > 0 {
			print("good recipe list")
		} else {
			// ajouter une alerte
			print("error recipe List")
		}
		return cell
	}
}





//recipeName.text =  String(resultTest.recipeName)
//timeLabel.text = String("\((resultTest.totalTimeInSeconds)/60) mn")
//timeLabel.text = String("\((resultMatches[0].totalTimeInSeconds)/60) mn")
//rateLabel.text = String("\(resultMatches[0].rating) / 5")
//			let images = resultMatches[0].smallImageUrls![0].updateSizeUrlImageString
//			if let url = NSURL(string: images) {
//				if let data = NSData(contentsOf: url as URL) {
//					imageRecipe.contentMode = UIView.ContentMode.scaleAspectFit
//					imageRecipe.image = UIImage(data: data as Data)
//				}
//			}
