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

	
	@IBAction func favoriteButtonAction(_ sender: UIBarButtonItem) {
		print("unlike favorite")
		favoriteButton.tintColor = .white
		//Recipe.deleteFavoriteID(id: (recipeDetailAPIResult?.id)!)
	}
	@IBAction func getRecipeDirection(_ sender: UIButton) {
		print("getRecipeDirection Detail")
//		guard let source = favoriteList[0].sourceRecipe else {return}// erreur d'indexpath
//		guard let url = URL(string:source) else {return}
//		print(url)
//		UIApplication.shared.open(url)
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
		recipeName.text = recipe[indexPath.row].name
		guard let time = Int(recipe[indexPath.row].totalTime!) else {return cell}
		timeLabel.text = String("\(time / 60) mn")
		guard let rate = recipe[indexPath.row].rate else {return cell}
		rateLabel.text = rate + " / 5 "
		//guard let test = favoriteList[indexPath.row].instructions?.nameInstruction else {return}
			//print(test)
		
		//cell.textLabel?.text = favoriteList[indexPath.row].instructions?.name
	
		
			//favoriteList[indexPath.row]
//		if let ingredientLines = recipeDetailAPIResult?.ingredientLines[indexPath.row]  {
//			cell.textLabel!.text = "\(String(describing: ingredientLines))"
//		}
		//let images = resultMatches.smallImageUrls![0].updateSizeUrlImageString
		//let source = recipeDetailAPIResult!.source
		//guard let recipeDetailAPIResult = recipeDetailAPIResult else {return 0}
		//guard let images = recipeDetailAPIResult?.images[0].hostedLargeUrl else {return cell}
//		if let url = URL(string: images) {
//			if let data = try? Data(contentsOf: url as URL) {
//				print(data)
//				imageRecipe.contentMode = UIView.ContentMode.scaleAspectFit
//				imageRecipe.image = UIImage(data: data as Data)
//			} else {
//				imageRecipe.backgroundColor = Colors.grey
//				imageRecipe.image = UIImage(named: "recipe-no-photo.jpg") //UIImage(defaultImage)
//			}
//		}
		return cell
	}
}
