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
	
	var recipeDetail: Recipe?// reception du segue
	var instructionTab = [String]()
	@IBAction func favoriteButtonAction(_ sender: UIBarButtonItem) {
		print("unlike favorite")
		guard let recipeID = recipeDetail?.id else {return}
		if Recipe.checkFavoriteID(id: recipeID) {
			Recipe.deleteFavoriteID(id: recipeID)
			favoriteButton.tintColor = .white
			try? AppDelegate.viewContext.save()
		} else {
			print("erreur (Recipe.checkFavoriteID)")
			favoriteButton.tintColor = .red
		}
		try? AppDelegate.viewContext.save()
		navigationController?.popViewController(animated: true)
	}
	@IBAction func getRecipeDirection(_ sender: UIButton) {
		guard let urlSource = recipeDetail?.url else {return}
		guard let url = URL(string: urlSource) else {return}
		UIApplication.shared.open(url)
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
		recipeDetailDisplay()
		let test = recipeDetail?.ingredients?.allObjects as? [Ingredient]
		print(test?.description as Any)

		

		print(instructionTab.description)
		//print(instructionsEntityAllObjects as? String)
		instructionsTableView.dataSource = self
		favoriteButton.tintColor = .red
	}
	override func viewWillAppear(_ animated: Bool) {

		// cf bouton favoris
	}
	func recipeDetailDisplay() {
		guard let name = recipeDetail?.name else {return}
		recipeName.text = name.firstUppercased
		guard let time = recipeDetail?.totalTime else {return}
		guard let timeToInt = Int(time) else {return}
		timeLabel.text = String(timeToInt.convertIntToTime)
		guard let rate = recipeDetail?.rate else {return}
		rateLabel.text = rate + " / 5 "
		guard let data = recipeDetail?.imageData else {return}
		imageRecipe.image = UIImage(data: data)
	}
}
extension FavoriteDetailVC: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return instructionTab.count
	}
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteIngredientDetailCell", for: indexPath)
		let instructionsEntityAllObjects = recipeDetail?.instructions?.allObjects as? [Instruction]
		let instructions = instructionsEntityAllObjects?.map({$0.name ?? ""}) ?? []
		instructionTab = instructions
		let instructionIndex = instructionTab[indexPath.row]
		cell.textLabel?.text = instructionIndex.firstUppercased
		print("recipe ID true")
		
		return cell
	}
}

