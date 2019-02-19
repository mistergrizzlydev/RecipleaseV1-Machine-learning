//
//  AllergiesViewController.swift
//  RecipleaseV1
//
//  Created by VINCENT BOULANGER on 17/02/2019.
//  Copyright © 2019 VBoulanger. All rights reserved.
//

import UIKit

class AllergiesVC: UIViewController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.navigationItem.title = "Reciplease"
		//allergiesTableView.delegate = self as! UITableViewDelegate
		allergiesTableView.dataSource = self
		// Do any additional setup after loading the view.
	}
	
	@IBOutlet weak var allergiesTableView: UITableView!
	
	let tab = ["soja","bière","orange"]
}

extension AllergiesVC : UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return tab.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "AllergiesCell", for : indexPath) as? AllergiesTableViewCell else {
			return UITableViewCell()
		}
		//cell.nameAllergy
//		let allergies = Allergies.list[indexPath.row].allergy
//		//cell.allergyOutletCell?.text = allergies.description
//		
//		for (key, _) in allergies {
//			cell.allergyOutletCell?.text = "\(key)"
//			if cell.allergySwitch.isOn  {
//				print("vrai")
//				//Allergies.list[0].allergy
//			} else {
//				print("faux")
//			}
//		}
		return cell
	}
	
	
	
}
//
//
///*
//// MARK: - Navigation
//
//// In a storyboard-based application, you will often want to do a little preparation before navigation
//override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//// Get the new view controller using segue.destination.
//// Pass the selected object to the new view controller.
//}
//*/
//
//
//
//
////set_metadata('allergy', [{"id":"393","shortDescription":"Gluten-Free","longDescription":"Gluten-Free","searchValue":"393^Gluten-Free","type":"allergy","ordinal":2,"localesAvailableIn":["en-US"]},{"id":"394","shortDescription":"Peanut-Free","longDescription":"Peanut-Free","searchValue":"394^Peanut-Free","type":"allergy","ordinal":3,"localesAvailableIn":["en-US"]},{"id":"398","shortDescription":"Seafood-Free","longDescription":"Seafood-Free","searchValue":"398^Seafood-Free","type":"allergy","ordinal":7,"localesAvailableIn":["en-US"]},{"id":"399","shortDescription":"Sesame-Free","longDescription":"Sesame-Free","searchValue":"399^Sesame-Free","type":"allergy","ordinal":8,"localesAvailableIn":["en-US"]},{"id":"400","shortDescription":"Soy-Free","longDescription":"Soy-Free","searchValue":"400^Soy-Free","type":"allergy","ordinal":9,"localesAvailableIn":["en-US"]},{"id":"396","shortDescription":"Dairy-Free","longDescription":"Dairy-Free","searchValue":"396^Dairy-Free","type":"allergy","ordinal":5,"localesAvailableIn":["en-US"]},{"id":"397","shortDescription":"Egg-Free","longDescription":"Egg-Free","searchValue":"397^Egg-Free","type":"allergy","ordinal":6,"localesAvailableIn":["en-US"]},{"id":"401","shortDescription":"Sulfite-Free","longDescription":"Sulfite-Free","searchValue":"401^Sulfite-Free","type":"allergy","ordinal":10,"localesAvailableIn":["en-US"]},{"id":"395","shortDescription":"Tree Nut-Free","longDescription":"Tree Nut-Free","searchValue":"395^Tree Nut-Free","type":"allergy","ordinal":4,"localesAvailableIn":["en-US"]},{"id":"392","shortDescription":"Wheat-Free","longDescription":"Wheat-Free","searchValue":"392^Wheat-Free","type":"allergy","ordinal":1,"localesAvailableIn":["en-US"]}]);
