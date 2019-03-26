//
//  FavoriteDetailVC.swift
//  RecipleaseV1
//
//  Created by VINCENT BOULANGER on 07/03/2019.
//  Copyright © 2019 VBoulanger. All rights reserved.
//

import UIKit
import CoreData

class FavoriteDetailVC: UIViewController {
	@IBOutlet weak var backViewRateAndTime: UIView!
	@IBOutlet weak var imageRecipe: UIImageView!
	@IBOutlet weak var rateLabel: UILabel!
	@IBOutlet weak var timeLabel: UILabel!
	@IBOutlet weak var recipeName: UILabel!
	@IBOutlet weak var instructionsTableView: UITableView!
	@IBOutlet weak var getDirections: UIButton!
	@IBOutlet weak var favoriteButton: UIBarButtonItem!
	var recipe = Recipe.fetchAll()
	var recipeDetail: Recipe?
	// reception du segue
	
	@IBAction func favoriteButtonAction(_ sender: UIBarButtonItem) {
		print("unlike favorite")
		let instructionsEntity = Instruction(context: AppDelegate.viewContext)
		let recipe = Recipe(context: AppDelegate.viewContext)
		guard let recipeID = recipeDetail?.id else {return}
		//print("recipe : \(recipeID.description)")
		print(recipe)
		if Recipe.checkFavoriteID(id: recipeID) {
			Recipe.deleteFavoriteID(id: recipe.id!)
		}
		//Recipe.deleteFavoriteID(id: (recipeDetailAPIResult?.id)!)
		//Go controller précédent
		//navigationController?.popViewController(animated: true)
	}
	@IBAction func getRecipeDirection(_ sender: UIButton) {
		print("getRecipeDirection Detail")

	}
	func designButton() {
		backViewRateAndTime.layer.cornerRadius = 5
		getDirections.layer.cornerRadius = 5
	}
	override func viewDidLoad() {
		super.viewDidLoad()
		print("viewDidLoad Favorites")
		self.navigationItem.title = "Favorites"
		designButton()
		recipe = Recipe.fetchAll()
		instructionsTableView.dataSource = self
		instructionsTableView.reloadData()
		favoriteButton.tintColor = .red
	}
	override func viewWillAppear(_ animated: Bool) {
		recipe = Recipe.fetchAll()
		instructionsTableView.reloadData()
	}
	let test = ["test1", "test2", "test3", "test4"]
}


extension FavoriteDetailVC: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return recipe.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteIngredientDetailCell", for: indexPath)
//		recipeName.text =  recipeDetailAPIResult?.name
//		rateLabel.text = String("\((recipeDetailAPIResult!.rating))/5")
//		timeLabel.text = String("\((recipeDetailAPIResult!.totalTimeInSeconds)/60) mn")
//
//		if let ingredientLines = recipeDetailAPIResult?.ingredientLines[indexPath.row]  {
//			cell.textLabel!.text = "\(String(describing: ingredientLines))"
//		}
		//recipeName.text =
		recipeName.text = recipe[indexPath.row].name
		guard let time = Int(recipe[indexPath.row].totalTime!) else {return cell}
		timeLabel.text = String("\(time / 60) mn")
		guard let rate = recipe[indexPath.row].rate else {return cell}
		
		rateLabel.text = rate + " / 5 "
		print("================ instruction entity")
		let instructionsEntity = Instruction(context: AppDelegate.viewContext)
		//guard let instructions = instructionsEntity else {return cell}
		guard let recipeID = recipeDetail?.id else {return cell}
		print("recipeID \(recipeID)")
		cell.detailTextLabel?.text = "test ingredients"
//		if Recipe.checkFavoriteID(id: recipeID) {
//
//			cell.textLabel?.text = recipeDetail?.id
//		}
		
		if let ingredientLines = instructionsEntity.name  {
			print("ingredientLines : \(ingredientLines)")
		}
		
		return cell
	}
}
