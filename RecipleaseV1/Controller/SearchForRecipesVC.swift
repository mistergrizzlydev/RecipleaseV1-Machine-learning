//
//  SearchForRecipesViewController.swift
//  RecipleaseV1
//
//  Created by VINCENT BOULANGER on 11/12/2018.
//  Copyright © 2018 VBoulanger. All rights reserved.
//

import UIKit

class SearchForRecipesVC: UIViewController {
	
	//===================================
	// -MARK : OUTLETS
	//===================================
	@IBOutlet weak var searchIngredientsTextField: UITextField!
	@IBOutlet weak var addButtonOutlet: UIButton!
	@IBOutlet weak var clearButtonOutlet: UIButton!
	@IBOutlet weak var ingredientsTableView: UITableView!
	@IBOutlet weak var ActivityIndicator: UIActivityIndicatorView!
	@IBOutlet weak var searchForRecipesButton: UIButton!

	@IBOutlet weak var recognizer: UIView!
	let recipeAPIService = RecipeAPIService()
	var ingredientList = [String]()
	var matches: [Match]!
	func addIngredientToDisplay() {
		if searchIngredientsTextField.text == "" {
			presentAlert(title: "An Omission ?", message: "You must enter an ingredient ! ")
			return
		} else {
			guard let userIngredients = searchIngredientsTextField.text?.changeToArray else {return}
			for i in userIngredients {
				ingredientList.append(i.firstUppercased)
			}
			ingredientsTableView.reloadData()
			hideKeyboard()
		}
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "segueRecipesToDisplay" {
			if let matches = matches {
				let successVC = segue.destination as! ResultListRecipeVC
				successVC.matches = matches
			}
		}
	}
	
	func requestSearchForRecipes() {
		//toggleActivityIndicator(shown: true)
		print("requestSearchForRecipes")
		recipeAPIService.requestListRecipes(recipeList: ingredientList) { (success, dataYum) in
			if success {
				
				guard let dataYum = dataYum else {return}
				self.matches = dataYum.matches
				self.performSegue(withIdentifier: "segueRecipesToDisplay", sender: nil)
			}
		}
	}
	
	//===================================
	// -MARK : IBACTION
	//===================================
	@IBAction func addButtonIBAction(_ sender: UIButton) {
		print("add ingredient button")
		addIngredientToDisplay()
		searchIngredientsTextField.text = ""
		ingredientsTableView.reloadData()
	}
	@IBAction func clearButtonIBAction(_ sender: UIButton) {
		print("clear ingredient button")
		ingredientList.removeAll()
		searchIngredientsTextField.text = ""
		ingredientsTableView.reloadData()
	}
	@IBAction func searchForRecipeIBActionButton(_ sender: UIButton) {
		print("searchForRecipeIBActionButton")
		//addIngredientToDisplay()
		toggleActivityIndicator(shown: true)
		requestSearchForRecipes()
	}
	
	//================================
	// MARK : - Animation
	//================================
	func toggleActivityIndicator(shown: Bool) {
		searchForRecipesButton.isHidden = shown
		ActivityIndicator.isHidden = !shown
	}
	//================================
	// MARK : - ToolBar
	//================================
	private func createToolbar() {
		let toolBar = UIToolbar()
		toolBar.sizeToFit()
		toolBar.barTintColor = .black
		toolBar.tintColor = .white
		let searchRecipeButton = UIBarButtonItem(title: "Go Search", style: .plain, target: self, action: #selector(SearchForRecipesVC.searchForRecipeIBActionButton))
		toolBar.setItems ([searchRecipeButton], animated: false)
		toolBar.isUserInteractionEnabled = true
		searchIngredientsTextField.inputAccessoryView = toolBar
	}
	//================================
	// MARK : - ViewDidLoad
	//================================
	func designItemBarNavigation() {
		self.navigationItem.title = "Reciplease"
		//	let test = UINavigationBar.appearance()
		//	test.layer = UIColor.white
	}
	override func viewDidLoad() {
		super.viewDidLoad()
		//toggleActivityIndicator(shown: false)
		designItemBarNavigation()
		ingredientsTableView.dataSource = self
		
		createToolbar()
		addButtonOutlet.layer.cornerRadius = 5
		clearButtonOutlet.layer.cornerRadius = 5
		searchForRecipesButton.layer.cornerRadius = 5
	}
	override func viewWillAppear(_ animated: Bool) {
		toggleActivityIndicator(shown: false)
		ingredientsTableView.reloadData()
	}
}
extension SearchForRecipesVC: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return ingredientList.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientsCell", for: indexPath)
		let recipe = ingredientList[indexPath.row]
		cell.textLabel?.text = "\(recipe)"
		return cell
	}
	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		ingredientList.remove(at: indexPath.row)
		ingredientsTableView.deleteRows(at: [indexPath], with: .automatic) // je confirme la suppression
		ingredientsTableView.reloadData()
	}
}

extension SearchForRecipesVC : UITextFieldDelegate {
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
