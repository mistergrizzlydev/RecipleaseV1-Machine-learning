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
	@IBOutlet weak var ingredientsTableView: UITableView!
	@IBOutlet weak var getDirections: UIButton!
	@IBOutlet weak var favoriteButton: UIBarButtonItem!
	var favoriteList = Favorite.fetchAll()
	//let favorite = Favorite(context: AppDelegate.viewContext)//
	@IBAction func getRecipeDirection(_ sender: UIButton) {
		print("getRecipeDirection")
		//guard let source = recipeDetailAPIResult?.source.sourceRecipeUrl else {return}
//		print("source : \(source)")
//		guard let url = URL(string: source) else {return}
	//	UIApplication.shared.open(url)
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
		//ingredientsTableView.dataSource = self
		//ingredientsTableView.reloadData()
	}
	override func viewWillAppear(_ animated: Bool) {
		ingredientsTableView.reloadData()
	}
}


extension FavoriteDetailVC: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		//guard let recipeDetailAPIResult = recipeDetailAPIResult else {return 0}
		// ajouter bdd relationships
		//return recipeDetailAPIResult.ingredientLines.count
		return favoriteList.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientDetailCell", for: indexPath)
		//recipeName.text =  recipeDetailAPIResult?.name
		recipeName.text = favoriteList[0].nameRecipe
		//rateLabel.text = String("\((recipeDetailAPIResult!.rating))/5")
		//rateLabel.text =
		//timeLabel.text = String("\((recipeDetailAPIResult!.totalTimeInSeconds)/60) mn")
		//timeLabel.text =
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
