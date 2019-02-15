//
//  RecipeViewController.swift
//  RecipleaseV1
//
//  Created by VINCENT BOULANGER on 07/02/2019.
//  Copyright © 2019 VBoulanger. All rights reserved.
//

import UIKit

class RecipeViewController: UIViewController {
	@IBOutlet weak var backViewRateAndTime: UIView!
	@IBOutlet weak var rateLabel: UILabel!
	@IBOutlet weak var timeLabel: UILabel!
	@IBOutlet weak var recipeName: UILabel!
	@IBOutlet weak var ingredientsTableView: UITableView!
	var matches: [Match]!
	
	@IBOutlet weak var imageRecipe: UIImageView!
	
	@IBOutlet weak var getDirections: UIButton!
	override func viewDidLoad() {
			super.viewDidLoad()
		print("RecipeViewController")
		displayRecipe()
		backViewRateAndTime.layer.cornerRadius = 5
		backViewRateAndTime.layer.cornerRadius = 5
		getDirections.layer.cornerRadius = 5
		ingredientsTableView.reloadData()
		}
	override func viewWillAppear(_ animated: Bool) {
		displayRecipe()
		ingredientsTableView.reloadData()
	}
		func displayRecipe() {
			guard let resultMatches = matches else {return}
			if matches!.count > 0 {
				for i in 0..<resultMatches.count {
					recipeName.text = String(resultMatches[i].recipeName)
				}
				
//				timeLabel.text = String("\((resultMatches[0].totalTimeInSeconds)/60) mn")
//				rateLabel.text = String("\(resultMatches[0].rating) / 5")
//				let images = resultMatches[0].smallImageUrls![0].updateSizeUrlImageString
//				if let url = NSURL(string: images) {
//					if let data = NSData(contentsOf: url as URL) {
//						imageRecipe.contentMode = UIView.ContentMode.scaleAspectFit
//						imageRecipe.image = UIImage(data: data as Data)
//					}
//				}
			} else {
				// ajouter une alerte
				print("error recipe List")
			}
		}

}


extension RecipeViewController: UITableViewDataSource {
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		guard let matches = matches else {return 0}
		return matches[0].ingredients.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientCell", for: indexPath) as? RecipeTableViewCell else {
			return UITableViewCell()
		}
		let resultMatches = matches![indexPath.row].ingredients
		print("resultMatches")
		for i in resultMatches {
			cell.textLabel?.text = i
		}
		
		
		
		return cell
	}
}


