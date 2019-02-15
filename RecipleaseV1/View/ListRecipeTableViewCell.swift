//
//  ResultRecipeTableViewCell.swift
//  RecipleaseV1
//
//  Created by VINCENT BOULANGER on 26/01/2019.
//  Copyright © 2019 VBoulanger. All rights reserved.
//

import UIKit

class ListRecipeTableViewCell: UITableViewCell  {
	
	@IBOutlet weak var topImageViewCell: UIImageView!
	@IBOutlet weak var recipeName: UILabel!
	@IBOutlet weak var timeLabel: UILabel!
	
	@IBOutlet weak var ratesLabel: UILabel!
	
	@IBOutlet weak var whiteView: UIView!


	override func awakeFromNib() {
        super.awakeFromNib()
    }
	
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }


}

