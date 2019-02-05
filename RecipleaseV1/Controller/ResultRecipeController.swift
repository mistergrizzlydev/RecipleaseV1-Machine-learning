//
//  ResultRecipeController.swift
//  RecipleaseV1
//
//  Created by VINCENT BOULANGER on 22/01/2019.
//  Copyright © 2019 VBoulanger. All rights reserved.
//

//import Foundation

import UIKit

class ResultRecipeController: ViewController {
	
	@IBOutlet weak var resultRecipeTableView: UITableView!
	
	let recipeAPIService = RecipeAPIService()
	let recipeApIResult: RecipeAPIResult? = nil
	let listOfRecipes = [String]()

	
	//================================
	// MARK : - ViewDidLoad
	//================================
	override func viewDidLoad() {
		super.viewDidLoad()
		

		print("viewDidLoad()")
		
		//}
	}
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		resultRecipeTableView.reloadData()
	}
	var testTab = ["test1","test2","test3","test4","test5"]
	var ListTuples = ("","","","","")
}

extension ResultRecipeController : UITableViewDataSource {
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return testTab.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "ResultRecipeCell", for: indexPath) as? ResultRecipeTableViewCell else {
			return UITableViewCell()
		}

		//var recipeListTuples = ()
//		var recipeName = ""
//		var rates = ""
//		var totalTime = ""
//		var list = recipesService.listsRecipes[indexPath.row]
		
		return cell
	}
}
