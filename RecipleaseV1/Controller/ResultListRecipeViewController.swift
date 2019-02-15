//
//  ResultListRecipeViewController.swift
//  RecipleaseV1
//
//  Created by VINCENT BOULANGER on 09/02/2019.
//  Copyright © 2019 VBoulanger. All rights reserved.
//

import UIKit

class ResultListRecipeViewController: UIViewController {
	var userListIngredient = [String]()
	var recipeAPIService = RecipeAPIService()
	@IBOutlet weak var recipesTableView: UITableView!
	var matches: [Match]?
	
    override func viewDidLoad() {
        super.viewDidLoad()
		recipesTableView.delegate = self
		recipesTableView.dataSource = self
		let nib = UINib(nibName: "CellTableViewXib", bundle: nil)
		recipesTableView.register(nib, forCellReuseIdentifier: "CustomTableViewCell")
		recipesTableView.reloadData()
		
    }
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		recipesTableView.reloadData()
	}
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "SegueRecipeToSuccess" {
			if let matches = matches {
				let successVC = segue.destination as! RecipeViewController
				successVC.matches = matches
			}
		}
	}
//	func requestForIngredients() {
//		//toggleActivityIndicator(shown: true)
//		print("request for ingredient")
//		recipeAPIService.requestRecipes(recipeList: userListIngredient) { (success, dataYum) in
//			if success {
//				print("test success")
//				guard let dataYum = dataYum else {return}
//				self.matches = dataYum.matches
//				print("test234 :ingredients")
//				print(dataYum.matches[0].ingredients)
//				self.performSegue(withIdentifier: "SegueRecipeToSuccess", sender: nil)
//			}
//		}
//	}
}
extension ResultListRecipeViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		print(matches![indexPath.row])
		recipeSelection(index: indexPath.row)
	}
	func recipeSelection(index: Int) {
		let idRecipe = matches![index].id
		recipeAPIService.requestRecipes(recipeList: [idRecipe]) { (success, dataYum) in
			if success {
				print("test success")
				guard let dataYum = dataYum else {return}
				self.matches = dataYum.matches
				print("test234 :ingredients")
				//print(dataYum.matches[0].ingredients)
				self.performSegue(withIdentifier: "SegueRecipeToSuccess", sender: nil)
			}
		}
	}
}
extension ResultListRecipeViewController: UITableViewDataSource {
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
