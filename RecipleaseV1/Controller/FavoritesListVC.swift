//
//  FavoriteVC.swift
//  RecipleaseV1
//
//  Created by VINCENT BOULANGER on 04/03/2019.
//  Copyright © 2019 VBoulanger. All rights reserved.
// https://www.raywenderlich.com/472-uisearchcontroller-tutorial-getting-started
import CoreData
import UIKit

class FavoritesListVC: UIViewController {
	var matches: [Match]!
	var recipe = Recipe.fetchAll() // var qui va contenir tous les objets favoris
	var recipeDetail: Recipe?
	@IBOutlet weak var favoriteTableView: UITableView!
	
	@IBAction func deleteFavorites(_ sender: UIBarButtonItem) {
		print("delete all favorites")
		Recipe.deleteAll()
		recipe.removeAll()
		favoriteTableView.reloadData()
		try? AppDelegate.viewContext.save()
	}
	override func viewDidLoad() {
		super.viewDidLoad()
		print("FavoritesVC ")
		self.navigationItem.title = "Favorites"
		let nib = UINib(nibName: "CellTableViewXib", bundle: nil)
		favoriteTableView.register(nib, forCellReuseIdentifier: "CustomTableViewCell")
		favoriteTableView.delegate = self
		favoriteTableView.dataSource = self
		recipe = Recipe.fetchAll()
		favoriteTableView.tableFooterView = UIView()
	}
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		recipe = Recipe.fetchAll()
		favoriteTableView.reloadData()
	}
	
//	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//		if segue.identifier == "SegueRecipeToSuccess" {
//			let successVC = segue.destination as! RecipeVC
//			successVC.recipeDetailAPIResult = sender as? RecipeDetailAPIResult
//		}
//	}
}

//=================================================
// MARK : - ResultListRecipeVC: UITableViewDelegate
//=================================================
extension FavoritesListVC: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		self.performSegue(withIdentifier: "segueFavoritesToDisplay", sender: nil)
		
	}
	//faire passer avec un segue l'id de la recette
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "segueFavoritesToDisplay" {
			guard let successVC = segue.destination as? FavoriteDetailVC else {return}
			successVC.recipeDetail = sender as? Recipe
		}
	}
}
extension FavoritesListVC: UITableViewDataSource {
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return recipe.count
	}
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as? CustomTableViewCell else {return UITableViewCell()}
		
		cell.recipeLabel.text = recipe[indexPath.row].name
		guard let time = Int(recipe[indexPath.row].totalTime!) else {return cell}
		cell.timeLabel.text = String("\(time / 60) mn")
		guard let rate = recipe[indexPath.row].rate else {return cell}
		cell.rateLabel.text = rate + " / 5 "
		let ingredientEntity = Ingredient(context: AppDelegate.viewContext)
		let instructionsEntity = Instruction(context: AppDelegate.viewContext)
		print()
		cell.ingredientsLabel.text = "ingredientEntity.name"
		print("ingredientEntity.name : \(ingredientEntity.name)")
		//guard let test = ingredientEntity else {return cell}
//		for i in instructionsEntity {
//			cell.ingredientsLabel?.text = i
//		}
//		for _ in resultMatches.ingredients {
//			let test = resultMatches.ingredients[0..<3]
//			cell.ingredientsLabel?.text = "\(test[0].firstUppercased), \(test[1].firstUppercased), \(test[2].firstUppercased)"
//		}


		guard let imageData = recipe[indexPath.row].imageData else {return cell}
		print("imageData : \(imageData)")
		if (recipe[indexPath.row].imageData != nil) {
			print("bonne photo")
			let image = UIImage(data: recipe[indexPath.row].imageData!)
			cell.imageRecipe.image = image
		} else {
			cell.imageRecipe.backgroundColor = Colors.grey
			let image = UIImage(named: "pizza.jpeg")
			cell.imageRecipe.image = image //UIImage(defaultImage)
		}
	
		print(imageData)
		return cell
	}

	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		recipe.remove(at: indexPath.row)
		favoriteTableView.deleteRows(at: [indexPath], with: .automatic) // je confirme la suppression
		favoriteTableView.reloadData()
		// probleme delete id
		//AppDelegate.viewContext.delete(listOfFavoriteRecipe[indexPath.row]) syskam
		guard let recipeDetails = recipeDetail else {return}
		print("id 2:============\(recipeDetails.id!)")
		Recipe.deleteFavoriteID(id: recipeDetails.id!)
		try? AppDelegate.viewContext.save()
	}
	func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
		let label = UILabel()
		label.text = "Add some recipes in your favorites"
		label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
		label.textAlignment = .center
		label.textColor = .darkGray
		return label
	}
	func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
		return recipe.isEmpty ? 200: 0
	}
}

