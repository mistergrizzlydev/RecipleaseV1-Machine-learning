//
//  CustomTableViewCell.swift
//  RecipleaseV1
//
//  Created by VINCENT BOULANGER on 15/02/2019.
//  Copyright © 2019 VBoulanger. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

	@IBOutlet weak var recipeLabel: UILabel!
	@IBOutlet weak var imageRecipe: UIImageView!
	@IBOutlet weak var timeLabel: UILabel!
	@IBOutlet weak var rateLabel: UILabel!
	@IBOutlet weak var ingredientLabel: UILabel!
	
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
