//
//  ResultListRecipeViewController.swift
//  RecipleaseV1
//
//  Created by VINCENT BOULANGER on 09/02/2019.
//  Copyright © 2019 VBoulanger. All rights reserved.
//

import UIKit

class ResultListRecipeVC: UIViewController {
	var userListIngredient = [String]()
	var recipeAPIService = RecipeAPIService()
	@IBOutlet weak var recipesTableView: UITableView!
	var matches: [Match]?
	//========================================
	// MARK : - viewDidLoad() & viewWillAppear
	//========================================
    override func viewDidLoad() {
        super.viewDidLoad()
		let nib = UINib(nibName: "CellTableViewXib", bundle: nil)
		recipesTableView.register(nib, forCellReuseIdentifier: "CustomTableViewCell")
		self.navigationItem.title = "Reciplease"
		recipesTableView.delegate = self
		recipesTableView.dataSource = self
		recipesTableView.reloadData()
    }
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		recipesTableView.reloadData()
	}
	
	//================================
	// MARK : - prepare fo segue
	//================================
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "SegueRecipeToSuccess" {
			if let matches = matches {
				let successVC = segue.destination as! RecipeVC
				successVC.matches = matches
			}
		}
	}
}
//================================================
// MARK : - ResultListRecipeVC: UITableViewDelegate
//=================================================
extension ResultListRecipeVC: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		print("didSelect : \(matches![indexPath.row].id)")
		let idRecipe = matches![indexPath.row].id
		recipeAPIService.requestRecipes(recipeList: [idRecipe]) { (success, dataRecipeId) in
			if success {
				print("test success")
				guard let dataRecipeId = dataRecipeId else {return}
				self.matches = dataRecipeId.matches
				self.performSegue(withIdentifier: "SegueRecipeToSuccess", sender: nil)
			}
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
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as? CustomTableViewCell else {
			return UITableViewCell()
		}
		let resultMatches = matches![indexPath.row]
		if matches!.count > 0 {
			cell.recipeLabel.text = String(resultMatches.recipeName)
			cell.timeLabel.text = String("\((resultMatches.totalTimeInSeconds)/60) mn")
			cell.ratesLabel.text = String("\(resultMatches.rating) / 5")
			let images = resultMatches.smallImageUrls![0].updateSizeUrlImageString
			if let url = NSURL(string: images) {
				if let data = NSData(contentsOf: url as URL) {
					cell.recipeImage.contentMode = UIView.ContentMode.scaleAspectFit
					cell.recipeImage.image = UIImage(data: data as Data)
				}
			}
		} else {
			// ajouter une alerte
			print("error recipe List")
		}
		return cell
	}
}
