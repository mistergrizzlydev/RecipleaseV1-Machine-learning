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
	var recipe = Recipe.fetchAll() // var qui va contenir tous les objets favoris
	
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
		let nib = UINib(nibName: "CustomRecipeViewCellXib", bundle: nil)
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
}

//=================================================
// MARK : - ResultListRecipeVC: UITableViewDelegate
//=================================================
extension FavoritesListVC: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		self.performSegue(withIdentifier: "segueFavoritesToDisplay", sender: recipe[indexPath.row].id)
	}
	//faire passer avec un segue l'id de la recette
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "segueFavoritesToDisplay" {
			guard let successVC = segue.destination as? FavoriteDetailVC else {return}
			let recipeEntity = Recipe.fetchRecipe(id: sender as? String ?? "default value").first
			successVC.recipeDetail = recipeEntity
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
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as? CustomRecipeViewCell else {return UITableViewCell()}
		let resultRecipe = recipe[indexPath.row]
		cell.recipeEntity = resultRecipe
		return cell
	}

	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		guard let recipeID = recipe[indexPath.row].id else {return}
		if Recipe.checkFavoriteID(id: recipeID) {
			Recipe.deleteFavoriteID(id: recipeID)
			recipe.remove(at: indexPath.row)
			favoriteTableView.deleteRows(at: [indexPath], with: .automatic )
			try? AppDelegate.viewContext.save()
		} else {
			print("erreur (Recipe.deleteFavoriteID)")
		}
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

