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

	let recipeAPIService = RecipeAPIService()
	var recipes = Recipes()
	@IBOutlet weak var searchForRecipesUIActivityIndicatorOutlet: UIActivityIndicatorView!
	@IBOutlet weak var searchForRecipesOutlet: UIButton!
	

	func addIngredient() {
		if searchIngredientsTextField.text == "" {
			print("Vous devez entrer un ingrédient")
			alertEmptyTextField()
		} else {
			print("Vous avez ajouté un ingrédient")
		
			guard let userIngredients = searchIngredientsTextField.text else {return}

			
		
			recipes.currentIngredient.append(userIngredients)
			// mapper pour accpeter plusieurs ingredients à la fois
			
			UserDefaults.standard.set(userIngredients, forKey: "ingredientsSaved")
			
			let recipeUser = recipes.currentIngredient.map({$0}).joined(separator: "+")
			recipes.ingredientsUserToUrl = recipeUser
			print("=====================")
			print("recipes.ingredientsUserToUrl: \(recipes.ingredientsUserToUrl)")
			print("recipes.currentIngredient: \(recipes.currentIngredient)")
			print("recipeUser: \(recipeUser)")
			
			print("userIngredients : \(userIngredients)")

			print("=====================")
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
		recipes.currentIngredient.removeAll()
		searchIngredientsTextField.text = ""
		ingredientsTableView.reloadData()
	}
	
	@IBAction func searchForRecipeIBActionButton(_ sender: UIButton) {
		print("searchForRecipeIBActionButton")
		//toggleActivityIndicator(shown: false)
		addIngredient()
		requestSearchForRecipes()
	}
	func requestSearchForRecipes() {
		recipeAPIService.requestRecipes { (success, dataYum) in
			if success {
				guard let dataYum = dataYum?.matches[0].recipeName else {return}
				print("\(dataYum)")
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
			super.viewDidLoad()
			toggleActivityIndicator(shown: true)
			createToolbar()
			// call userfault
			//let ingredient1 = UserDefaults.standard.object(forKey: "ingredient1") as? String
			
			//let ingredientsRequestData: NSFetchRequest<IngredientCD> = IngredientCD.fetchRequest() //creation de la requete ingredient dans CoreData
			//guard let ingredients = try? AppDelegate.viewContext.fetch(ingredientsRequestData) else {return} // recupération des infos ingredienst en bdd Core Data
		}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		//ingredientsCD = IngredientCD.all // rechargement visuel de la liste dans Core Data
		ingredientsTableView.reloadData()
	}
}
extension SearchForRecipesViewController: UITableViewDataSource {
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		//guard let test = recipes.recipes else {return}
		return recipes.currentIngredient.count
		//return Recipes.shared.recipes.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientsCell", for: indexPath)
		
		let recipe = recipes.currentIngredient[indexPath.row]
		//let ingredientsSaved = UserDefaults.standard.string(forKey: "ingredientsSaved") ?? "€"
		cell.textLabel?.text = "\(recipe)"
		return cell
	}
		func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
			recipes.currentIngredient.remove(at: indexPath.row)
			ingredientsTableView.deleteRows(at: [indexPath], with: .automatic) // je confirme la suppression
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
		addIngredient()
		hideKeyboard()
	
		return true
	}
}
