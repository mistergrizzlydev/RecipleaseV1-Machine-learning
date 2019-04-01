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
	
	//========================================
	// MARK : - viewDidLoad() & viewWillAppear
	//========================================
    override func viewDidLoad() {
        super.viewDidLoad()
		let nib = UINib(nibName: "CustomRecipeViewCellXib", bundle: nil)
		recipesTableView.register(nib, forCellReuseIdentifier: "CustomTableViewCell")
		self.navigationItem.title = "Reciplease"
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
			print("idRecipeTest : \(self.recipeAPIService.urlConstructRecipeDetail(recipeID: idRecipe))")
			if success {
				print("test success")
				guard let recipe = recipe else {return}
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
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as? CustomRecipeViewCell else {
			return UITableViewCell()
		}
		
//		if matches!.count > 0 {
//			cell.recipeLabel.text = String(resultMatches.recipeName)
//			cell.timeLabel.text = String("\((resultMatches.totalTimeInSeconds)/60) mn")
//			cell.rateLabel.text = String("\(resultMatches.rating) / 5")
//			for _ in resultMatches.ingredients {
//				let ingredient = resultMatches.ingredients[0..<3]
//				cell.ingredientsLabel?.text = "\(ingredient[0].firstUppercased), \(ingredient[1].firstUppercased), \(ingredient[2].firstUppercased)"
//			}
//			let images = resultMatches.smallImageUrls![0].updateSizeUrlImageString
//			if let url = URL(string: images) {
//				if let data = try? Data(contentsOf: url as URL) {
//					cell.imageRecipe.image = UIImage(data: data as Data)
//				}
//			}
//		} else {
//			// ajouter une alerte!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
//			//self.performSegue(withIdentifier: "SegueRecipeToSuccess", sender: recipe)
//			print("error recipe List")
//		}
		let resultMatches = matches![indexPath.row]
		
		cell.recipe = resultMatches
		return cell
	}
}
