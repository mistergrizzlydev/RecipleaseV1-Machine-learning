//
//  RecipeViewController.swift
//  RecipleaseV1
//
//  Created by VINCENT BOULANGER on 07/02/2019.
//  Copyright © 2019 VBoulanger. All rights reserved.
//

import UIKit
import CoreData

class RecipeVC: UIViewController {
	@IBOutlet weak var backViewRateAndTime: UIView!
	@IBOutlet weak var imageRecipe: UIImageView!
	@IBOutlet weak var rateLabel: UILabel!
	@IBOutlet weak var timeLabel: UILabel!
	@IBOutlet weak var recipeName: UILabel!
	@IBOutlet weak var ingredientsTableView: UITableView!
	@IBOutlet weak var getDirections: UIButton!
	@IBOutlet weak var favoriteButton: UIBarButtonItem!
	var recipe = Recipe.fetchAll()
	var matches: [Match]!
	var recipeDetailAPIResult: RecipeDetailAPIResult?
	
	
	@IBAction func favoriteButtonAction(_ sender: UIBarButtonItem) {
		print("add favorite button")


		// check si la recette est dans core data grace à l'id si oui je supprime la recette si non je l'enregistre. + modifier l'apparence du bouton
			if Recipe.checkFavoriteID(id: (recipeDetailAPIResult?.id)!) {
				print("delete favorite")
				favoriteButton.tintColor = .white
				Recipe.deleteFavoriteID(id: (recipeDetailAPIResult?.id)!)
			} else {
				print("save favorite")
				saveFavorite()
				favoriteButton.tintColor = .red
			}
	}
	
	func saveFavorite() {
			let recipe = Recipe(context: AppDelegate.viewContext)// création de l'objet favoris
			guard let recipeName = recipeDetailAPIResult?.name,
				let idRecipe = recipeDetailAPIResult?.id,
				let rateRecipe = recipeDetailAPIResult?.rating,
				let totalTimeRecipe = recipeDetailAPIResult?.totalTimeInSeconds,
				let source = recipeDetailAPIResult?.source.sourceRecipeUrl//,
				//let instructions = recipeDetailAPIResult?.ingredientLines,
				//let imageFavorite = recipeDetailAPIResult?.images[0]
				else {return}
			recipe.id = idRecipe
			recipe.name = recipeName
			recipe.rate = String(rateRecipe)
			recipe.totalTime = String(totalTimeRecipe)
			//recipe.instructions = instructions
			recipe.source = source
			//favorite.favorite = favoriteChoice
			try? AppDelegate.viewContext.save() // sauvegarde du context avec try car cela peut générer une erreur.
				//let test = try? NSData(data: )
		//favorite.imageRecipe = Data(data: imageFavorite)
		//let imageConverted = imageFavorite
		//favorite.imageRecipe = Data(imageFavorite)
	}

	
	// launch URL
	@IBAction func getRecipeDirection(_ sender: UIButton) {
		print("getRecipeDirection")
		guard let source = recipeDetailAPIResult?.source.sourceRecipeUrl else {return}
		print("source : \(source)")
		guard let url = URL(string: source) else {return}
		UIApplication.shared.open(url)
	}
	func designButton() {
		backViewRateAndTime.layer.cornerRadius = 5
		getDirections.layer.cornerRadius = 5
	}
	override func viewDidLoad() {
		super.viewDidLoad()
		print("viewDidLoad Reciple detail ")
		self.navigationItem.title = "Reciplease"
		designButton()
		ingredientsTableView.dataSource = self
		ingredientsTableView.reloadData()
		}
	override func viewWillAppear(_ animated: Bool) {
		ingredientsTableView.reloadData()
		// 1- check dans core data si la recette est présente en fonction de l'id de la recette est en favori ou pas.
		
		
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
//		if let ingredientLines = recipeDetailAPIResult?.ingredientLines[indexPath.row]  {
//			cell.textLabel!.text = "\(String(describing: ingredientLines))"
//		}
		//let images = resultMatches.smallImageUrls![0].updateSizeUrlImageString
		//let source = recipeDetailAPIResult!.source
		//guard let recipeDetailAPIResult = recipeDetailAPIResult else {return 0}
		guard let images = recipeDetailAPIResult?.images[0].hostedLargeUrl else {return cell}
		if let url = URL(string: images) {
			if let data = try? Data(contentsOf: url as URL) {
				print(data)
				imageRecipe.contentMode = UIView.ContentMode.scaleAspectFit
				imageRecipe.image = UIImage(data: data as Data)
			}
		} else {
			imageRecipe.backgroundColor = Colors.grey
			imageRecipe.image = UIImage(named: "recipe-no-photo.jpg") //UIImage(defaultImage)
		}
		return cell
	}
}
