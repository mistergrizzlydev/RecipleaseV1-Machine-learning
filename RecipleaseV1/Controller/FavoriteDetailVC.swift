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
	
	@IBAction func favoriteButtonAction(_ sender: UIBarButtonItem) {
		guard let recipeID = recipeDetail?.id else {return}
		if Recipe.checkFavoriteID(id: recipeID) {
			Recipe.deleteFavoriteID(id: recipeID)
			favoriteButton.tintColor = .white
			try? AppDelegate.viewContext.save()
		} else {
			favoriteButton.tintColor = .red
		}
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
		instructionsTableView.dataSource = self
		favoriteButton.tintColor = .red

	}
	func recipeDetailDisplay() {
		guard let name = recipeDetail?.name else {return}
		recipeName.text = name.firstUppercased
		guard let time = recipeDetail?.totalTime else {return}
		guard let timeToInt = Int(time) else {return}
		timeLabel.text = String(timeToInt.convertIntToTime)
		guard let rate = recipeDetail?.rate else {return}
		rateLabel.text = rate + "/5"
		guard let data = recipeDetail?.imageData else {return}
		imageRecipe.image = UIImage(data: data)
	}
	
}
extension FavoriteDetailVC: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		guard let recipeInstructions = recipeDetail?.instructions?.allObjects as? [Instruction] else {return 0}
		return recipeInstructions.count
	}
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteIngredientDetailCell", for: indexPath)
		guard let recipeDetail = recipeDetail else {return cell}
		guard let instruct = recipeDetail.instructions else {return cell}
		guard let allInstructions = instruct.allObjects as? [Instruction] else {return cell}
		let instructions = allInstructions[indexPath.row]
		guard let name = instructions.name else {return cell}
		cell.textLabel?.text = name
		return cell
	}
}

