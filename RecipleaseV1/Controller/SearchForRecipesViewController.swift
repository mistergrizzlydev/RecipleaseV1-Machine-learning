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
	//===================================
	// -MARK : IBACTION
	//===================================
	@IBAction func addButtonIBAction(_ sender: UIButton) {
	}
	@IBAction func clearButtonIBAction(_ sender: UIButton) {
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
		
	}
	
}


extension SearchForRecipesViewController {
	
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
