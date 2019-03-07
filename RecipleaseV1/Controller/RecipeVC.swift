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
	
	var matches: [Match]!
	var recipeDetailAPIResult: RecipeDetailAPIResult?
	
	@IBAction func favoriteButtonAction(_ sender: UIBarButtonItem) {
		print("add favorite button")
		// ajouter une alert : you added recipe with success
		saveFavorite()
	}
	func saveFavorite() {
		let favorite = Favorite(context: AppDelegate.viewContext)// création de l'objet favoris
		guard let recipeName = recipeName.text, let idRecipe = recipeDetailAPIResult?.id, let rateRecipe = rateLabel.text, let totalTimeRecipe = timeLabel.text, let imageFavorite = imageRecipe.image else {return}
		favorite.idRecipe = idRecipe
		favorite.nameRecipe = recipeName
		favorite.rateRecipe = rateRecipe
		favorite.totalTimeRecipe = totalTimeRecipe
		let imageConverted = imageFavorite
		//favorite.imageRecipe = Data(imageFavorite)
		try? AppDelegate.viewContext.save() // sauvegarde du context avec try car cela peut générer une erreur.
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
		//guard let recipeDetailAPIResult = recipeDetailAPIResult else {return 0}
		guard let images = recipeDetailAPIResult?.images[0].hostedLargeUrl else {return cell}
		if let url = URL(string: images) {
			if let data = try? Data(contentsOf: url as URL) {
				print(data)
				imageRecipe.contentMode = UIView.ContentMode.scaleAspectFit
				imageRecipe.image = UIImage(data: data as Data)
			} else {
				imageRecipe.backgroundColor = Colors.grey
				imageRecipe.image = UIImage(named: "recipe-no-photo.jpg") //UIImage(defaultImage)
			}
		}
		return cell
	}
}
