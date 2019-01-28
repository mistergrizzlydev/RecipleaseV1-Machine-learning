//
//  ProfilViewController.swift
//  RecipleaseV1
//
//  Created by VINCENT BOULANGER on 23/01/2019.
//  Copyright © 2019 VBoulanger. All rights reserved.
//

import Foundation
import UIKit

class ProfilViewController: ViewController {
	
	@IBOutlet weak var allergiesTableView: UITableView!
	
	
}

extension ProfilViewController : UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return Allergies.list.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "AllergiesCell", for : indexPath) as? AllergiesTableView else {
			return UITableViewCell()
		}
		
		let allergies = Allergies.list[indexPath.row].allergy
		//cell.allergyOutletCell?.text = allergies.description
		
		for (key, _) in allergies {
			cell.allergyOutletCell?.text = "\(key)"
			if cell.allergySwitch.isOn  {
				print("vrai")
				Allergies.list[0].allergy
			} else {
				print("faux")
			}
		}
		return cell
	}
	
	
}
//set_metadata('allergy', [{"id":"393","shortDescription":"Gluten-Free","longDescription":"Gluten-Free","searchValue":"393^Gluten-Free","type":"allergy","ordinal":2,"localesAvailableIn":["en-US"]},{"id":"394","shortDescription":"Peanut-Free","longDescription":"Peanut-Free","searchValue":"394^Peanut-Free","type":"allergy","ordinal":3,"localesAvailableIn":["en-US"]},{"id":"398","shortDescription":"Seafood-Free","longDescription":"Seafood-Free","searchValue":"398^Seafood-Free","type":"allergy","ordinal":7,"localesAvailableIn":["en-US"]},{"id":"399","shortDescription":"Sesame-Free","longDescription":"Sesame-Free","searchValue":"399^Sesame-Free","type":"allergy","ordinal":8,"localesAvailableIn":["en-US"]},{"id":"400","shortDescription":"Soy-Free","longDescription":"Soy-Free","searchValue":"400^Soy-Free","type":"allergy","ordinal":9,"localesAvailableIn":["en-US"]},{"id":"396","shortDescription":"Dairy-Free","longDescription":"Dairy-Free","searchValue":"396^Dairy-Free","type":"allergy","ordinal":5,"localesAvailableIn":["en-US"]},{"id":"397","shortDescription":"Egg-Free","longDescription":"Egg-Free","searchValue":"397^Egg-Free","type":"allergy","ordinal":6,"localesAvailableIn":["en-US"]},{"id":"401","shortDescription":"Sulfite-Free","longDescription":"Sulfite-Free","searchValue":"401^Sulfite-Free","type":"allergy","ordinal":10,"localesAvailableIn":["en-US"]},{"id":"395","shortDescription":"Tree Nut-Free","longDescription":"Tree Nut-Free","searchValue":"395^Tree Nut-Free","type":"allergy","ordinal":4,"localesAvailableIn":["en-US"]},{"id":"392","shortDescription":"Wheat-Free","longDescription":"Wheat-Free","searchValue":"392^Wheat-Free","type":"allergy","ordinal":1,"localesAvailableIn":["en-US"]}]);