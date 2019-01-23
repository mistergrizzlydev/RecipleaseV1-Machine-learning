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
		let cell = tableView.dequeueReusableCell(withIdentifier: "allergiesCell", for : indexPath)
		let allergies = Allergies.list[indexPath.row]
		cell.textLabel?.text = "\(allergies.nameAllergy)"
		
		return cell
	}
	
	
}
