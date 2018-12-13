//
//  SearchForRecipesViewController.swift
//  RecipleaseV1
//
//  Created by VINCENT BOULANGER on 11/12/2018.
//  Copyright © 2018 VBoulanger. All rights reserved.
//

import UIKit

class SearchForRecipesViewController: UIViewController {
	//===================================
	// -MARK : OUTLETS
	//===================================
	@IBOutlet weak var searchIngredientsTextFieldOutlet: UITextField!
	@IBOutlet weak var addButtonOutlet: UIButton!
	@IBOutlet weak var clearButtonOutlet: UIButton!
	@IBOutlet weak var ingredientsTableViewOutlet: UITableView!
	@IBOutlet weak var searchForRecipesUIActivityIndicatorOutlet: UIActivityIndicatorView!
	@IBOutlet weak var searchForRecipesOutlet: UIButton!
	var ingredientTab = ["Apple", "Tomatoes", "Curry", "Chicken"]
	//===================================
	// -MARK : IBACTION
	//===================================
	@IBAction func addButtonIBAction(_ sender: UIButton) {
		var test = searchIngredientsTextFieldOutlet.text
		ingredientTab.append(test!)
	}
	@IBAction func clearButtonIBAction(_ sender: UIButton) {
		ingredientTab.removeAll()
	}
	
	
	
	@IBAction func searchForRecipeIBActionButton(_ sender: UIButton) {
		print("searchForRecipeIBActionButton")
	}
	//================================
	// MARK : - Animation
	//================================
	func toggleActivityIndicator(shown: Bool) {
		searchForRecipesOutlet.isHidden = !shown
		searchForRecipesUIActivityIndicatorOutlet.isHidden = shown
	}
	//================================
	// MARK : - ViewDidLoad
	//================================
	override func viewDidLoad() {
		ingredientsTableViewOutlet.dataSource = self
	}
	
}


extension SearchForRecipesViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return ingredientTab.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "ingredientsCell", for: indexPath)
		
		if let titleLabel = cell.textLabel {
			titleLabel.text = ingredientTab[indexPath.row]
		}
		return cell
	}
}























extension SearchForRecipesViewController : UITextFieldDelegate {
	func hideKeyboard() {
		searchIngredientsTextFieldOutlet.resignFirstResponder()
	}
	@IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
		hideKeyboard()
	}
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		print("Return Pressed")
		//translation()
		return true
	}
}
