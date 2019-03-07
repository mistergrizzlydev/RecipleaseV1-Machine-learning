//
//  FavoriteVC.swift
//  RecipleaseV1
//
//  Created by VINCENT BOULANGER on 04/03/2019.
//  Copyright © 2019 VBoulanger. All rights reserved.
// https://www.raywenderlich.com/472-uisearchcontroller-tutorial-getting-started
import CoreData
import UIKit

class FavoritesVC: UIViewController {
	
	var matches: [Match]!
	//var favoriteList =  Favorite.all // var qui va contenir tous les objets favoris
	var favoriteList = Favorite.fetchAll()
	@IBOutlet weak var favoriteTableView: UITableView!
	
	
	@IBAction func deleteFavorites(_ sender: UIBarButtonItem) {
		Favorite.deleteAll()
		favoriteList.removeAll()
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
		favoriteTableView.tableFooterView = UIView()
	}
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		favoriteList = Favorite.fetchAll()
		favoriteTableView.reloadData()
	}

}

//================================================
// MARK : - ResultListRecipeVC: UITableViewDelegate
//=================================================
extension FavoritesVC: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		self.performSegue(withIdentifier: "segueFavoritesToDisplay", sender: nil)
	}
}
extension FavoritesVC: UITableViewDataSource {
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return favoriteList.count
	}
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as? CustomTableViewCell else {return UITableViewCell()}
			cell.recipeLabel.text = favoriteList[indexPath.row].nameRecipe
			cell.timeLabel.text = favoriteList[indexPath.row].totalTimeRecipe
			cell.ratesLabel.text = favoriteList[indexPath.row].rateRecipe
		
		return cell
	}
	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		favoriteList.remove(at: indexPath.row)
		favoriteTableView.deleteRows(at: [indexPath], with: .automatic) // je confirme la suppression
		favoriteTableView.reloadData()
		favoriteList = Favorite.fetchAll()
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
		return favoriteList.isEmpty ? 200: 0
	}
}

