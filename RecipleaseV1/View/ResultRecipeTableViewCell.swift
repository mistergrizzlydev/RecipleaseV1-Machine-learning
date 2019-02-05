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
	
	override func awakeFromNib() {
        super.awakeFromNib()
		//addShadow()
		
        // Initialization code
	
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
	func configure(ingredientsTab: [String]?) {
		var ingredientToList = ""
		//guard let titleRecipe = titleRecipe else {return}
		//test1.text = titleRecipe
		guard let ingredientsTab = ingredientsTab else {return}
		
		for i in ingredientsTab {
			ingredientToList = i
			print("i:\(i)")
			test1.text = ingredientToList
		}
		test1.text = ingredientToList
		//subtitleLabel.text = subtitle
	}
	func configure2( title: String) {
		//iconView.image = UIImage(named: icon)
		test1.text = title
		
	}
}

