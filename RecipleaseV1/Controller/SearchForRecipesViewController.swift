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
	@IBOutlet weak var searchIngredientsTextField: UITextField!
	@IBOutlet weak var addButtonOutlet: UIButton!
	@IBOutlet weak var clearButtonOutlet: UIButton!
	@IBOutlet weak var ingredientsTableView: UITableView!
	@IBOutlet weak var searchForRecipesUIActivityIndicatorOutlet: UIActivityIndicatorView!
	@IBOutlet weak var searchForRecipesButton: UIButton!
	
	let recipeApIResult: RecipeAPIResult? = nil
	let recipeAPIService = RecipeAPIService()
	var userListIngredient = [String]()
	
	
	
	
	
	
	func addIngredientToDisplay() {
		if searchIngredientsTextField.text == "" {
			print("Vous devez entrer un ingrédient")
			alertEmptyTextField()
			return
		} else {
			print("=====================")
			print("Good  ! Vous avez ajouté un ingrédient")
			guard let userIngredients = searchIngredientsTextField.text?.changeToArray else {return}
			for i in userIngredients {
				userListIngredient.append(i.firstUppercased)
			}
			print("=====================")
			ingredientsTableView.reloadData()
			hideKeyboard()
		}
	}
	func requestSearchForRecipes() {
//		recipeAPIService.requestRecipes(recipeList: userListIngredient) { (success, dataYum) in
//			if success {
//				print("test success")
//
//				guard let dataYum = dataYum?.matches else {return}
//				print(dataYum[0].recipeName)
////				list.recipeName = dataYum[0].recipeName
////				print(list.recipeName)
////				self.resultRecipeTableView.reloadData()
////				for i in dataYum {
////
////					recipeName = String(i.recipeName)
////					rates = String(i.rating)
////					totalTime = String(i.totalTimeInSeconds)
////
////					cell.nameRecipeOutlet.text = recipeName
////					cell.ratesLabel.text = rates
////					cell.timeLabel.text = totalTime
////
////					list.recipeName = recipeName
////					list.rating.append(rates)
////					list.totalTimeInSeconds.append(totalTime)
////
////					print(recipeName)
////
////				}
//			}
//			self.resultRecipeTableView.reloadData()
//		}
	}
	//===================================
	// -MARK : IBACTION
	//===================================
	
	@IBAction func addButtonIBAction(_ sender: UIButton) {
		print("add ingredient button")
		addIngredientToDisplay()
		searchIngredientsTextField.text = ""
	}
	@IBAction func clearButtonIBAction(_ sender: UIButton) {
		print("clear ingredient button")
		userListIngredient.removeAll()
		searchIngredientsTextField.text = ""
		ingredientsTableView.reloadData()
	}
	
	@IBAction func searchForRecipeIBActionButton(_ sender: UIButton) {
		print("searchForRecipeIBActionButton")
		//toggleActivityIndicator(shown: true)
		//searchIngredientsTextField.text = ""
		//addIngredient()
		requestSearchForRecipes()
		
	}
	
	//================================
	// MARK : - Animation
	//================================
	func toggleActivityIndicator(shown: Bool) {
		searchForRecipesButton.isHidden = shown
		searchForRecipesUIActivityIndicatorOutlet.isHidden = !shown
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
			//toggleActivityIndicator(shown: true)
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
		return userListIngredient.count
		//return Recipes.shared.recipes.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientsCell", for: indexPath)
		
		let recipe = userListIngredient[indexPath.row]
		//let ingredientsSaved = UserDefaults.standard.string(forKey: "ingredientsSaved") ?? "€"
		cell.textLabel?.text = "\(recipe)"
		return cell
	}
		func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
			userListIngredient.remove(at: indexPath.row)
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
		addIngredientToDisplay()
		hideKeyboard()
	
		return true
	}
}
