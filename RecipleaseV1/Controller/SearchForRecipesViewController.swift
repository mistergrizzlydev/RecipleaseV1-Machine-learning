//
//  SearchForRecipesViewController.swift
//  RecipleaseV1
//
//  Created by VINCENT BOULANGER on 11/12/2018.
//  Copyright © 2018 VBoulanger. All rights reserved.
//

import UIKit
import Alamofire
import CoreData

class SearchForRecipesViewController: UIViewController {
	//===================================
	// -MARK : OUTLETS
	//===================================
	@IBOutlet weak var searchIngredientsTextField: UITextField!
	@IBOutlet weak var addButtonOutlet: UIButton!
	@IBOutlet weak var clearButtonOutlet: UIButton!
	@IBOutlet weak var ingredientsTableView: UITableView!
	
	var ingredientAPIService = IngredientAPIService()
	var ingredients = IngredientCD.all
	var ingredientEnum:IngredientsSearch?
	
	@IBOutlet weak var searchForRecipesUIActivityIndicatorOutlet: UIActivityIndicatorView!
	@IBOutlet weak var searchForRecipesOutlet: UIButton!
	
	//var ingredientTab = ["Apple", "Tomatoes", "Curry", "Chicken"]
	//var ingredientTab2:Ingredients = [Ingredients.ingredient1.rawValue, Ingredients.ingredient2.rawValue]
	//private var currentIngredient: [(Ingredients.RawValue, Ingredients.RawValue)] = [("", "")]
	//private var currrentIngredient: [(String, String)] = []
	
	var currentIngredient = [String]()
	
	func addIngredient() {
		if searchIngredientsTextField.text == "" {
			print("Vous devez entrer un ingrédient")
			alertEmptyTextField()
		} else {
			print("Vous avez ajouté un ingrédient")
			
			guard let search = searchIngredientsTextField.text else {return}
			print("test2: \(currentIngredient)")
			currentIngredient.append(search)
	
			print(ingredientAPIService.getUrlRequest(ingredients: [.ingredient1]))
			print("search :\(search)")
			let ingredientUser = currentIngredient.map({$0}).joined(separator: "+")
			ingredientAPIService.ingredientsUser = ingredientUser
			print(currentIngredient.map({$0}).joined(separator: "+") )
			print(ingredientAPIService.getUrlRequest(ingredients: [.ingredient1]))
			ingredientsTableView.reloadData()
			print(currentIngredient.count)
			hideKeyboard()
		}
	}
	//===================================
	// -MARK : IBACTION
	//===================================
	@IBAction func requestSearchForRecipesAction(_ sender: UITextField) {
		//addIngredient()
		
	}
	
	@IBAction func searchForRecipeIBActionButton(_ sender: UIButton) {
		print("searchForRecipeIBActionButton")
		//toggleActivityIndicator(shown: false)
		addIngredient()
		requestSearchForRecipes()
	}
	@IBAction func addButtonIBAction(_ sender: UIButton) {
		print("add ingredient button")
		addIngredient()
		searchIngredientsTextField.text = ""
	}
	@IBAction func clearButtonIBAction(_ sender: UIButton) {
		print("clear ingredient button")
		currentIngredient.removeAll()
		searchIngredientsTextField.text = ""
	}
	
	
	func requestSearchForRecipes() {
		ingredientAPIService.requestRecipes(ingredients: [.ingredient1, .ingredient2]) { (success, recipeList) in
			if success {
				print("request recipes succes")
//				self.currentIngredient.0 = "test current ingredient 1"
//				self.currentIngredient.1 = "test current ingredient 2"
				guard let recipeList = recipeList else {return}
			}
		}
	}
	
	//================================
	// MARK : - Animation
	//================================
	func toggleActivityIndicator(shown: Bool) {
		searchForRecipesOutlet.isHidden = !shown
		searchForRecipesUIActivityIndicatorOutlet.isHidden = shown
	}
	//================================
	// MARK : - ToolBar
	//================================
	private func createToolbar() {
		let toolBar = UIToolbar()
		toolBar.sizeToFit()
		toolBar.barTintColor = .black
		toolBar.tintColor = .white
		let searchRecipeButton = UIBarButtonItem(title: "Recherche une recette", style: .plain, target: self, action: #selector(SearchForRecipesViewController.searchForRecipeIBActionButton))
		toolBar.setItems ([searchRecipeButton], animated: false)
		toolBar.isUserInteractionEnabled = true
		searchIngredientsTextField.inputAccessoryView = toolBar
		
	}
	//================================
	// MARK : - ViewDidLoad
	//================================
	override func viewDidLoad() {
		toggleActivityIndicator(shown: true)
		createToolbar()
		ingredientsTableView.dataSource = self
	}
	
}


extension SearchForRecipesViewController: UITableViewDataSource, UITableViewDelegate {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return currentIngredient.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "ingredientsCell", for: indexPath)
		
		if let titleLabel = cell.textLabel {
			titleLabel.text = currentIngredient[indexPath.row]
		}
		//let currentIngredient = ingredientTab[indexPath.row]
		cell.textLabel?.text = currentIngredient[indexPath.row]
		ingredientsTableView.reloadData()
		return cell
	}
	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		currentIngredient.remove(at: indexPath.row)
		tableView.deleteRows(at: [indexPath], with: .automatic) // je confirme la suppression
		try? AppDelegate.viewContext.save()
		ingredientsTableView.reloadData()
	}
}


extension SearchForRecipesViewController : UITextFieldDelegate {
	func hideKeyboard() {
		searchIngredientsTextField.resignFirstResponder()
	}
	@IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
		hideKeyboard()
	}
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		print("Return Pressed")
		hideKeyboard()
		//recherche()
		return true
	}
}
