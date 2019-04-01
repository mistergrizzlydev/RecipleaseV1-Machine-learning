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
		deleteFavoriteID()
		//Go controller précédent
		//navigationController?.popViewController(animated: true)
	}
	func deleteFavoriteID() {
		guard let recipeID = recipeDetail?.id else {return}
		if Recipe.checkFavoriteID(id: recipeID) {
			print("delete favorite")
			favoriteButton.tintColor = .white
			Recipe.deleteFavoriteID(id: recipeID)
			try? AppDelegate.viewContext.save()
		} else {
			print("save favorite")
			favoriteButton.tintColor = .red
		}
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
}


extension FavoriteDetailVC: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return recipe.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteIngredientDetailCell", for: indexPath)
		guard let time = Int(recipe[indexPath.row].totalTime!) else {return cell}
		timeLabel.text = String("\(time.convertIntToTime)")
		guard let rate = recipe[indexPath.row].rate else {return cell}
		rateLabel.text = rate + " / 5 "
		print("================ instruction entity")
		
		let recipeInstructionsAllObjects = recipeDetail?.instructions?.allObjects as? [Instruction]
		guard let resultInstructions = recipeInstructionsAllObjects else {return cell}
		let instructions = resultInstructions.map({$0.name ?? ""})
		let instructionsString = instructions.joined(separator: ", ")
		cell.detailTextLabel?.text = instructionsString.firstUppercased
		
		return cell
	}
}
