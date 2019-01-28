//
//  ResultRecipeTableViewCell.swift
//  RecipleaseV1
//
//  Created by VINCENT BOULANGER on 26/01/2019.
//  Copyright © 2019 VBoulanger. All rights reserved.
//

import UIKit

class ResultRecipeTableViewCell: UITableViewCell  {
	
	
	
	@IBOutlet weak var test1: UILabel!
	@IBOutlet weak var test2: UILabel!
	@IBOutlet weak var test3: UILabel!
	
	@IBOutlet weak var topImageViewCell: UIImageView!
	@IBOutlet weak var catLabel: UILabel!
	@IBOutlet weak var nameRecipeOutlet: UILabel!
	
	@IBOutlet weak var timeLabel: UILabel!
	@IBOutlet weak var ratesLabel: UILabel!
	@IBOutlet weak var peopleLabel: UILabel!
	@IBOutlet weak var whiteView: UIView!
	let recipeAPIService = RecipeAPIService()
	var recipes = Recipes()
	func requestSearchForRecipes() {
		
	}
	override func awakeFromNib() {
        super.awakeFromNib()
		addShadow()
		requestSearchForRecipes()
        // Initialization code
		recipeAPIService.requestRecipes { (success, dataYum) in
			if success {
				guard let dataYum = dataYum?.matches else {return}
				
				print("data yum \(dataYum)")
				for i in dataYum {
					let test = i.ingredients
					self.ratesLabel.text = String(i.rating)
					self.test1.text = String(i.ingredients.description)
					print(self.test1)
				}
			}
		}
    }
	func configure(title: String) {

		test1.text = title
		//subtitleLabel.text = subtitle
	}
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
	private func addShadow() {
		whiteView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7).cgColor
		whiteView.layer.shadowRadius = 2.0
		whiteView.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
		whiteView.layer.shadowOpacity = 2.0
	}
}
extension ResultRecipeTableViewCell : UITableViewDataSource {
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return recipes.currentIngredient.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "ResultRecipeCell", for: indexPath) as? ResultRecipeTableViewCell else {
			return UITableViewCell()
		}
		let test = recipes.currentIngredient[indexPath.row]
		
		print("test53: \(test)")
		//let test2 = cell.configure(title: test.description )
		cell.nameRecipeOutlet.text = String(test.description)
		return cell
	}
}
