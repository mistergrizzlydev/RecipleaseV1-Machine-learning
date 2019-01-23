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
	
	@IBOutlet weak var searchForRecipesUIActivityIndicatorOutlet: UIActivityIndicatorView!
	@IBOutlet weak var searchForRecipesOutlet: UIButton!
	
	
	@objc func addIngredient() {
		if searchIngredientsTextField.text == "" {
			print("Vous devez entrer un ingrédient")
			alertEmptyTextField()
		} else {
			print("Vous avez ajouté un ingrédient")
		
			guard let ingredientsUser = searchIngredientsTextField.text else {return}
			ingredientAPIService.currentIngredient.append(ingredientsUser)
			let ingredientUser = ingredientAPIService.currentIngredient.map({$0}).joined(separator: "+")
			ingredientAPIService.ingredientsUser = ingredientUser

			print("url: \(ingredientAPIService.getUrlRequest())")
			//ingredientsTableView.reloadData()
			print("currentIngredient.count : \(ingredientAPIService.currentIngredient.count)")
			print("currentIngredient.text : \(ingredientAPIService.currentIngredient)")
			ingredientsTableView.reloadData()
			hideKeyboard()
		}
	}
	//===================================
	// -MARK : IBACTION
	//===================================
	@IBAction func searchForRecipesTextField(_ sender: UITextField) {
		//addIngredient()
		
	}
	
	
	@IBAction func addButtonIBAction(_ sender: UIButton) {
		print("add ingredient button")
		addIngredient()
		searchIngredientsTextField.text = ""
	}
	@IBAction func clearButtonIBAction(_ sender: UIButton) {
		print("clear ingredient button")
		ingredientAPIService.currentIngredient.removeAll()
		searchIngredientsTextField.text = ""
	}
	
	@IBAction func searchForRecipeIBActionButton(_ sender: UIButton) {
		print("searchForRecipeIBActionButton")
		//toggleActivityIndicator(shown: false)
		addIngredient()
		requestSearchForRecipes()
	}
	func requestSearchForRecipes() {
		ingredientAPIService.requestRecipes() { (success, recipeList) in
			if success {
				print("request recipes succes")
				self.searchIngredientsTextField.text = recipeList!
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
		//let ingredientsRequestData: NSFetchRequest<IngredientCD> = IngredientCD.fetchRequest() //creation de la requete ingredient dans CoreData
		//guard let ingredients = try? AppDelegate.viewContext.fetch(ingredientsRequestData) else {return} // recupération des infos ingredienst en bdd Core Data
		
	}
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		//ingredientsCD = IngredientCD.all // rechargement visuel de la liste
		ingredientsTableView.reloadData()
	}
}
extension SearchForRecipesViewController: UITableViewDataSource {
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return ingredientAPIService.currentIngredient.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientsCell", for: indexPath)
		
		let ingredient = ingredientAPIService.currentIngredient[indexPath.row]
		cell.textLabel?.text = ingredient
		//cell.textLabel?.text = ingredient.count
		return cell
	}
//		func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//			ingredientAPIService.currentIngredient.remove(at: indexPath.row)
//			ingredientsTableView.deleteRows(at: [indexPath], with: .automatic) // je confirme la suppression
//			try? AppDelegate.viewContext.save()
//			ingredientsTableView.reloadData()
//		}
}

//extension SearchForRecipesViewController: UITableViewDataSource, UITableViewDelegate {
//	func numberOfComponents(in pickerView: UIPickerView) -> Int {
//		return 1
//	}
//	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//		return ingredientsCD.count
//	}
//
//	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//		let cell:UITableViewCell = ingredientsTableView.dequeueReusableCell(withIdentifier: "ingredientsCell", for: indexPath)
//
//
//		try? AppDelegate.viewContext.save()
//		ingredientsTableView.reloadData()
//		return cell
//	}
//	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//		currentIngredient.remove(at: indexPath.row)
//		ingredientsTableView.deleteRows(at: [indexPath], with: .automatic) // je confirme la suppression
//		try? AppDelegate.viewContext.save()
//		ingredientsTableView.reloadData()
//	}
//}































extension SearchForRecipesViewController : UITextFieldDelegate {
	func hideKeyboard() {
		searchIngredientsTextField.resignFirstResponder()
	}
	@IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
		hideKeyboard()
	}
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		print("Return Pressed")
		addIngredient()
		hideKeyboard()
		return true
	}
}
