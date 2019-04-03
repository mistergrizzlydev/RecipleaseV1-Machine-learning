//
//  CustomTableViewCell.swift
//  RecipleaseV1
//
//  Created by VINCENT BOULANGER on 15/02/2019.
//  Copyright © 2019 VBoulanger. All rights reserved.
//

import UIKit

class CustomRecipeViewCell: UITableViewCell {

	@IBOutlet weak var recipeLabel: UILabel!
	@IBOutlet weak var imageRecipe: UIImageView!
	@IBOutlet weak var timeLabel: UILabel!
	@IBOutlet weak var rateLabel: UILabel!
	@IBOutlet weak var ingredientsLabel: UILabel!
	var recipe:Match! {
		didSet {
//			if recipe.count > 0 {
			recipeLabel.text = recipe.recipeName
			timeLabel.text = String(recipe.totalTimeInSeconds.convertIntToTime)
			rateLabel.text = String("\(recipe.rating) / 5")
			let ingredients = recipe.ingredients.map({$0.firstUppercased})
			let ingredientsString = ingredients.joined(separator: ", ")
			ingredientsLabel.text = String(ingredientsString)
			let images = recipe.smallImageUrls![0]
			if let url = URL(string: images) {
				if let data = try? Data(contentsOf: url as URL) {
					imageRecipe.image = UIImage(data: data as Data)
				}
			}
			//	} else {
			//		ajouter une alerte!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
			//		self.performSegue(withIdentifier: "SegueRecipeToSuccess", sender: recipe)
			//		print("error recipe List")
			//	}
		}
	}
	var recipeEntity: Recipe! {
		didSet {
			recipeLabel.text = recipeEntity.name
			//guard let time = Int(recipe[indexPath.row].totalTime!) else {return cell}
			guard let time = Int(recipeEntity.totalTime!) else {return}
			timeLabel.text = "\(time.convertIntToTime)" // gerer les heures - > extension de string
			guard let rate = recipeEntity.rate else {return}
			rateLabel.text = "\(rate) / 5 "
			
			let recipeEntityIngredient = recipeEntity.ingredients?.allObjects as? [Ingredient]
			//print("recipeEntity.\(String(describing: recipeEntityIngredient.))")
			guard let ingredients = recipeEntityIngredient else {return}
			
			let ingredientsMap = ingredients.map({$0.name!}).joined(separator: ", ")
			print("ingredientsMap \(ingredientsMap.firstUppercased)")
			ingredientsLabel.text = "@@@@@@@@@@@@@@@@@"
			//let ingredientsToString = ingredientsMap.joined(separator: ", ")
			//ingredientsLabel?.text = String(ingredientsToString.firstUppercased)
		
			//let ingredientsString = ingredientsMap joined(separator: ", ")
			//print("ingredientsString 22 : \(ingredientsString.firstUppercased)")
			//let images = ingredientEntities![0].
		//==================================================================================================
			//let ingredientEntity = Ingredient(context: AppDelegate.viewContext)
			//let instructionsEntity = Instruction(context: AppDelegate.viewContext)
			//cell.ingredientsLabel.text = "ingredientEntity.name : \(ingredientEntity.name)"
			//print("ingredientEntity.name : \(ingredientEntity.name)")
			//guard let test = ingredientEntity else {return cell}
		//==================================================================================================
			//ingredientsLabel?.text = ingredientsString.firstUppercased
		//==================================================================================================
			//		for _ in resultMatches.ingredients {
			//			let test = resultMatches.ingredients[0..<3]
			//			cell.ingredientsLabel?.text = "\(test[0].firstUppercased), \(test[1].firstUppercased), \(test[2].firstUppercased)"
			//		}
			//==================================================================================================

//			guard let imageData = recipe[indexPath.row].imageData else {return cell}
//			print("imageData : \(imageData)")
//			if (recipe[indexPath.row].imageData != nil) {
//				print("bonne photo")
//				let image = UIImage(data: recipe[indexPath.row].imageData!)
//				cell.imageRecipe.image = image
//			} else {
//				cell.imageRecipe.backgroundColor = Colors.grey
//				let image = UIImage(named: "pizza.jpeg")
//				cell.imageRecipe.image = image //UIImage(defaultImage)
//			}
			//==================================================================================================
			//print(imageData)
		}
	}
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
	override func prepareForReuse() {
		super.prepareForReuse()
	}
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
