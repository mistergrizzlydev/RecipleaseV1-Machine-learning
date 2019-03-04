//
//  FavoriteVC.swift
//  RecipleaseV1
//
//  Created by VINCENT BOULANGER on 04/03/2019.
//  Copyright © 2019 VBoulanger. All rights reserved.
// https://www.raywenderlich.com/472-uisearchcontroller-tutorial-getting-started

import UIKit

class FavoritesVC: UIViewController {
	var test = ["test1", "test3", "test3"]
	
	var matches: [Match]!
	
	var favoriteList =  Favorites.fetchAll() // var qui va contenir tous les objets favoris
	
	@IBOutlet weak var favoriteTableView: UITableView!
	
	func setupNavigationsItems() {
		//navigationItem.leftBarButtonItem = UIBarButtonItem(title: NavigationBar, style: <#T##UIBarButtonItem.Style#>, target: <#T##Any?#>, action: <#T##Selector?#>)
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
		favoriteTableView.reloadData()
	}
	
}

extension FavoritesVC : UITableViewDelegate {
	
}
extension FavoritesVC: UITableViewDataSource {
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return test.count
		//return favoriteList.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as? CustomTableViewCell else {
			return UITableViewCell()
		}
		//let resultMatches = matches![indexPath.row]
		
//		if matches!.count > 0 {
			cell.recipeLabel.text = String(test.description)
//			//cell.recipeLabel.text = String(resultMatches.recipeName)
//			cell.timeLabel.text = String("\((resultMatches.totalTimeInSeconds)/60) mn")
//			cell.ratesLabel.text = String("\(resultMatches.rating) / 5")
//			let images = resultMatches.smallImageUrls![0].updateSizeUrlImageString
//			if let url = NSURL(string: images) {
//				if let data = NSData(contentsOf: url as URL) {
//					cell.recipeImage.contentMode = UIView.ContentMode.scaleAspectFit
//					cell.recipeImage.image = UIImage(data: data as Data)
//				}
//			}
//		} else {
//			// ajouter une alerte
//			print("error recipe List")
//		}
		return cell
	}
	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		test.remove(at: indexPath.row)
		favoriteTableView.deleteRows(at: [indexPath], with: .automatic) // je confirme la suppression
		favoriteTableView.reloadData()
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
		return test.isEmpty ? 200: 0
	}

	
	
}

