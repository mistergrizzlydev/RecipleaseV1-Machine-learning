//
//  allergiesTableView.swift
//  RecipleaseV1
//
//  Created by VINCENT BOULANGER on 24/01/2019.
//  Copyright © 2019 VBoulanger. All rights reserved.
//

import UIKit

class AllergiesTableView: UITableViewCell {

	@IBOutlet weak var allergyOutletCell: UILabel!
	
	@IBOutlet weak var allergySwitch: UISwitch!
	
	func configure(titleAllergy: String, AllergyOK: Bool) {
		
		allergyOutletCell.text = titleAllergy
		allergySwitch.isOn = AllergyOK
	}
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
