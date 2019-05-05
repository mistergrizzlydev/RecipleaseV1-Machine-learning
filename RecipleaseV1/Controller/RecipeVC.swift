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

	var ingredients = [String]()// segue reception
	var recipeDetailAPIResult: RecipeDetailAPIResult?
	
	// check si la recette est dans core data grace à l'id si oui je supprime la recette si non je l'enregistre. + modifier l'apparence du bouton
	@IBAction func favoriteButtonAction(_ sender: UIBarButtonItem) {
		print("add favorite button")
		checkFavoriteID()
	}
	func checkFavoriteID() {
		
		guard let recipeID = recipeDetailAPIResult?.id else {return}
		if Recipe.checkFavoriteID(id: (recipeID)) {
			print("delete favorite")
			favoriteButton.tintColor = .white
			Recipe.deleteFavoriteID(id: (recipeID))
			try? AppDelegate.viewContext.save()
		} else {
			print("save favorite")
			saveFavorite()
			favoriteButton.tintColor = .red
			try? AppDelegate.viewContext.save()
		}
	}
	func checkToColorFavoriteButton() {
		guard let recipeDetail = recipeDetailAPIResult else {return}
		if Recipe.checkFavoriteID(id: (recipeDetail.id)) {
			favoriteButton.tintColor = .red
		} else {
			favoriteButton.tintColor = .white
		}
	}
	func checkIngredientsEntity(recipeEntity: Recipe) {
		for ingredient in ingredients {
			let ingredientEntity = Ingredient(context: AppDelegate.viewContext)
			ingredientEntity.name = ingredient
			ingredientEntity.recipe = recipeEntity
		}
	}
	func checkInstructionsEntity(recipeEntity: Recipe) {
		guard let recipeDetailAPiResult = recipeDetailAPIResult else {return}
		let instructionsDetail = recipeDetailAPiResult.ingredientLines
		for instruction in instructionsDetail {
			let instructionsEntity = Instruction(context: AppDelegate.viewContext)
			instructionsEntity.name = instruction
			instructionsEntity.recipe = recipeEntity
		}
	}
	
	// launch URL
	@IBAction func getRecipeDirection(_ sender: UIButton) {
		print("getRecipeDirection")
		guard let urlSource = recipeDetailAPIResult?.source.sourceRecipeUrl else {return}
		print("source : \(urlSource)")
		guard let url = URL(string: urlSource) else {return}
		UIApplication.shared.open(url)
	}
	func designButton() {
		backViewRateAndTime.layer.cornerRadius = 5
		getDirections.layer.cornerRadius = 5
	}
	func saveFavorite() {
		let recipe = Recipe(context: AppDelegate.viewContext)// création de l'objet recette
		guard let recipeDetailAPiResult = recipeDetailAPIResult else {return}
		let recipeName = recipeDetailAPiResult.name
		let idRecipe = recipeDetailAPiResult.id
		let rateRecipe = recipeDetailAPiResult.rating
		let totalTimeRecipe = recipeDetailAPiResult.totalTimeInSeconds
		let url = recipeDetailAPiResult.source.sourceRecipeUrl
		recipe.id = idRecipe
		recipe.name = recipeName
		recipe.rate = String(rateRecipe)
		recipe.totalTime = String(totalTimeRecipe)
		recipe.url = url
		recipe.imageData = imageRecipe.image?.jpegData(compressionQuality: 0.75)
		checkInstructionsEntity(recipeEntity: recipe)
		checkIngredientsEntity(recipeEntity: recipe)
		 //sauvegarde du context avec try car cela peut générer une erreur.
	}
	override func viewDidLoad() {
		super.viewDidLoad()
		print("viewDidLoad Reciple detail ")
		self.navigationItem.title = "Reciplease"
		recipeDetailDisplay()
		designButton()
		ingredientsTableView.dataSource = self
		ingredientsTableView.reloadData()
		checkToColorFavoriteButton()
	}
	override func viewWillAppear(_ animated: Bool) {
		ingredientsTableView.reloadData()
		checkToColorFavoriteButton()
	}
	func recipeDetailDisplay() {
		guard let recipeDetailAPI = recipeDetailAPIResult else {return}
		recipeName.text =  recipeDetailAPI.name
		rateLabel.text = String("\((recipeDetailAPI.rating))/5")
		timeLabel.text = String("\((recipeDetailAPI.totalTimeInSeconds.convertIntToTime))")
		guard let image = recipeDetailAPI.images[0].hostedLargeUrl else {return}
		if let url = URL(string: image) {
			if let data = try? Data(contentsOf: url as URL) {
				print(data)
				imageRecipe.image = UIImage(data: data as Data)
			}
		} else {
			imageRecipe.backgroundColor = Colors.grey
			imageRecipe.image = UIImage(named: "recipe-no-photo.jpg") //UIImage(defaultImage)
		}
	}
}

extension RecipeVC: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		guard let recipeDetailAPIResult = recipeDetailAPIResult else {return 0}
		return recipeDetailAPIResult.ingredientLines.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientDetailCell", for: indexPath)
		if let ingredientLines = recipeDetailAPIResult?.ingredientLines[indexPath.row]  {
			cell.textLabel?.text = "\(String(describing: ingredientLines))"
		}
		return cell
	}
}
