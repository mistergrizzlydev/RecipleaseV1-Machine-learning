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
		}
	}
	func checkIngredientsEntity(recipeEntity: Recipe) {
		guard let matches = matches else {return}
		let ingredientEntity = Ingredient(context: AppDelegate.viewContext)
		for ingredients in matches[0].ingredients { // attention
			ingredientEntity.name = ingredients
			ingredientEntity.recipe = recipeEntity
		}
	}
	func checkInstructionsEntity(recipeEntity: Recipe) {
		guard let recipeDetailAPiResult = recipeDetailAPIResult else {return}
		 // création de l'objet instructions
		let instructionsEntity = Instruction(context: AppDelegate.viewContext) // création de l'objet instructions
		for instructions in recipeDetailAPiResult.ingredientLines {
			print("test instrauction : \(instructions)")
			instructionsEntity.name = instructions
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
		try? AppDelegate.viewContext.save() //sauvegarde du context avec try car cela peut générer une erreur.
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
		recipeName.text =  recipeDetailAPIResult?.name
		rateLabel.text = String("\((recipeDetailAPIResult!.rating))/5")
		timeLabel.text = String("\((recipeDetailAPIResult!.totalTimeInSeconds)/60) mn")
		guard let image = recipeDetailAPIResult?.images[0].hostedLargeUrl else {return}
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
			cell.textLabel!.text = "\(String(describing: ingredientLines))"
		}
		
		return cell
	}
}
