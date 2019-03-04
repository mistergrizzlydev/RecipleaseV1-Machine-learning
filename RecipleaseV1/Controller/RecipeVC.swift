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
	@IBOutlet weak var favoriteButton: UIBarButtonItem!
	//var favorite:Favorite?
	var matches: [Match]!
	var recipeDetailAPIResult: RecipeDetailAPIResult?
	
	@IBAction func favoriteButtonAction(_ sender: UIBarButtonItem) {
		print("add favorite button")
		// ajouter une alert : Vous avez bien ajouté
		guard let recipeName = recipeName.text, let idRecipe = recipeDetailAPIResult?.id else {return}
		let favorite = Favorites(context: AppDelegate.viewContext)
		favorite.
		// sauvegarder dans le 
		
	}
	
	
	
	
	// launch URL
	@IBAction func getRecipeDirection(_ sender: UIButton) {
		print("getRecipeDirection")
		guard let test = recipeDetailAPIResult else {return}
		guard let source = test.source.sourceRecipeURL else {return}
		print("source : \(test.name)")
		guard let url = URL(string: source) else {return}
		UIApplication.shared.open(url)
	}
	//guard let source = recipeDetailAPIResult?.source else {return ""}
	//print("test 23 : \(source)")
	
	//		@IBAction func getDirection() {
	//			guard let url = URL(string: recipe!.attribution.url) else {
	//				displayAlert(title: "Error", message: "Nop !")
	//				return
	//			}
	//			UIApplication.shared.open(url, options: [:], completionHandler: nil)
	//		}
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
		return recipeDetailAPIResult.ingredientLines.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientDetailCell", for: indexPath)
		recipeName.text =  recipeDetailAPIResult?.name
		rateLabel.text = String("\((recipeDetailAPIResult!.rating))/5")
		timeLabel.text = String("\((recipeDetailAPIResult!.totalTimeInSeconds)/60) mn")
		if let ingredientLines = recipeDetailAPIResult?.ingredientLines[indexPath.row]  {
			cell.textLabel!.text = "\(String(describing: ingredientLines))"
		}
		//let images = resultMatches.smallImageUrls![0].updateSizeUrlImageString
		//let source = recipeDetailAPIResult!.source
		guard let images = recipeDetailAPIResult?.images[0].hostedLargeURL else {return cell}
		if let url = NSURL(string: images) {
			if let data = NSData(contentsOf: url as URL) {
				print(data)
				imageRecipe.contentMode = UIView.ContentMode.scaleAspectFit
				imageRecipe.image = UIImage(data: data as Data)
			} else {
				imageRecipe.backgroundColor = Colors.grey
				imageRecipe.image = UIImage(named: "recipe-no-photo.jpg") //UIImage(defaultImage)
			}
		}
//		if result?.hostedLargeURL != nil {
//			print(result?.hostedLargeURL)
//			imageRecipe.image = UIImage(named:(result!.hostedLargeURL!)) //UIImage(named:(recipeDetailAPIResult?.images[0].hostedLargeURL)!)
//		} else {
//			imageRecipe.backgroundColor = Colors.grey
//			imageRecipe.image = UIImage(named: "recipe-no-photo.jpg") //UIImage(defaultImage)
//		}
		//if let images = recipeDetailAPIResult!.images[indexPath.row] {
//			print("images : \(String(describing: image))")
//			if let url = NSURL(string: image) {
//				if let data = NSData(contentsOf: url as URL) {
//					imageRecipe.contentMode = UIView.ContentMode.scaleAspectFit
//					imageRecipe.image = UIImage(data: data as Data)
//				}
//			}
		//}
		return cell
	}
}
