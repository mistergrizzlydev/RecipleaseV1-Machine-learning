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
	var matches: [Match]!
	var listIngredientsDetail = [String]()
	
	// launch URL
	@IBAction func getRecipeDirection(_ sender: UIButton) {
		guard let url = URL(string: "https://stackoverflow.com") else { return }
		UIApplication.shared.open(url)
	}
	
	
	override func viewDidLoad() {
			super.viewDidLoad()
		for i in matches {
			print(i.ingredients)
		}
		self.navigationItem.title = "Reciplease"
		designButton()
		print("RecipeViewController")
		ingredientsTableView.dataSource = self
		//displayRecipe()
		ingredientsTableView.reloadData()
		}
	override func viewWillAppear(_ animated: Bool) {
		//displayRecipe()
		ingredientsTableView.reloadData()
	}
	func designButton() {
		backViewRateAndTime.layer.cornerRadius = 5
		getDirections.layer.cornerRadius = 5
	}
//	func displayRecipe() {
//		//guard let resultMatches = matches else {return}
//
//	}
}

extension RecipeVC: UITableViewDataSource {
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		//guard let matches = matches else {return 0}
		return matches.count
	}
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientCell", for: indexPath) as? RecipeTableViewCell else {
			return UITableViewCell()
		}
		let resultMatches = matches![indexPath.row].ingredients
		print("resultMatches")
		print(resultMatches.description)
		if matches!.count > 0 {
			recipeName.text =  String(resultMatches[indexPath.row].description)
//			timeLabel.text = String("\((resultMatches[0].totalTimeInSeconds)/60) mn")
//			rateLabel.text = String("\(resultMatches[0].rating) / 5")
//			let images = resultMatches[0].smallImageUrls![0].updateSizeUrlImageString
//			if let url = NSURL(string: images) {
//				if let data = NSData(contentsOf: url as URL) {
//					imageRecipe.contentMode = UIView.ContentMode.scaleAspectFit
//					imageRecipe.image = UIImage(data: data as Data)
//				}
			}
//		} else {
//			// ajouter une alerte
//			print("error recipe List")
//		}
		for i in resultMatches {
			print("i: \(i)")
			cell.textLabel?.text = i.description
			recipeName.text = i.description
		}
		return cell
	}
}


