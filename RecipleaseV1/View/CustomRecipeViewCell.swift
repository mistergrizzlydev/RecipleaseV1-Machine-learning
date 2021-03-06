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
	
	func defaultImage() {
		imageRecipe.backgroundColor = Colors.grey
		let image = UIImage(named: "recipe-no-photo.jpeg")
		imageRecipe.image = image //UIImage(defaultImage)
	}
	var recipe:Match? {
		didSet {
			recipeLabel.text = recipe?.recipeName
			timeLabel.text = String(recipe?.totalTimeInSeconds.convertIntToTime ?? "")
			rateLabel.text = String("\(recipe?.rating) / 5")
			let ingredients = recipe?.ingredients.map({$0.firstUppercased})
			let ingredientsString = ingredients?.joined(separator: ", ")
			ingredientsLabel.text = ingredientsString
			guard let image = recipe?.smallImageUrls else {return}
			let images = image[0]
			if let url = URL(string: images) {
				if let data = try? Data(contentsOf: url as URL) {
					imageRecipe.image = UIImage(data: data as Data)
				} else {
					defaultImage()
				}
			}
		}
	}
	var recipeEntity:Recipe? {
		didSet {
			recipeLabel.text = recipeEntity?.name
			guard let time = Int(recipeEntity?.totalTime ?? "") else {return}
			timeLabel.text = "\(time.convertIntToTime)" // gerer les heures // minutes - > extension de string
			guard let rate = recipeEntity?.rate else {return}
			rateLabel.text = "\(rate) / 5 "
			let recipeEntityAllObjects = recipeEntity?.ingredients?.allObjects as? [Ingredient]
			let ingredients = recipeEntityAllObjects?.map({$0.name ?? ""}) ?? []
			let ingredientsString = ingredients.joined(separator: ", ")
			ingredientsLabel?.text = "\(ingredientsString.firstUppercased)"
			guard let data = recipeEntity?.imageData else {return}
			imageRecipe.image = UIImage(data: data)
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
