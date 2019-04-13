//
//  ResultListRecipeViewController.swift
//  RecipleaseV1
//
//  Created by VINCENT BOULANGER on 09/02/2019.
//  Copyright © 2019 VBoulanger. All rights reserved.
//
import UIKit

class ResultListRecipeVC: UIViewController {
	var recipeAPIService = RecipeAPIService()
	@IBOutlet weak var recipesTableView: UITableView!
	var matches: [Match]?
	var ingredients = [String]()
	
	
	func designItemBarNavigation() {
		self.navigationItem.title = "Reciplease"
		UINavigationBar.appearance().tintColor = .white
	}
	//========================================
	// MARK : - viewDidLoad() & viewWillAppear
	//========================================
    override func viewDidLoad() {
        super.viewDidLoad()
		let nib = UINib(nibName: "CustomRecipeViewCellXib", bundle: nil)
		recipesTableView.register(nib, forCellReuseIdentifier: "CustomTableViewCell")
		designItemBarNavigation()
		recipesTableView.delegate = self
		recipesTableView.dataSource = self
		recipesTableView.reloadData()
    }
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		//print(matches)
		recipesTableView.reloadData()
	}
}
//================================================
// MARK : - ResultListRecipeVC: UITableViewDelegate
//=================================================
extension ResultListRecipeVC: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		guard let idRecipe = matches?[indexPath.row].id else {return}
		recipeAPIService.requestRecipeDetail(recipeID: idRecipe) { (success, recipe) in
			if success {
				print("test success")
				guard let recipe = recipe else {return}
				guard let ingredients = self.matches?[indexPath.row].ingredients else {return}
				self.ingredients = ingredients // deballer
				//self.instructions = ( )
				self.performSegue(withIdentifier: "SegueRecipeToSuccess", sender: recipe)
			} else {
				print("request error")
			}
		}
	}
	//================================
	// MARK : - prepare fo segue
	//================================
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "SegueRecipeToSuccess" {
				let successVC = segue.destination as! RecipeVC
				successVC.recipeDetailAPIResult = sender as? RecipeDetailAPIResult
				successVC.ingredients = ingredients
		}
	}
}

//===================================================
// MARK : - ResultListRecipeVC: UITableViewDataSource
//===================================================
extension ResultListRecipeVC: UITableViewDataSource {
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		guard let matches = matches else {return 0}
		return matches.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as? CustomRecipeViewCell else {return UITableViewCell()}
		let resultMatches = matches![indexPath.row]
		cell.recipe = resultMatches
		return cell
	}
	func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
		let label = UILabel()
		label.text = "No matches found"
		label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
		label.textAlignment = .center
		label.textColor = .darkGray
		return label
	}
	func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
		guard let matchEmpty = matches?.isEmpty else {return 0}
		return matchEmpty ? 200: 0
	}
}
