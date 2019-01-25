//
//  RecipeProtocol.swift
//  RecipleaseV1
//
//  Created by VINCENT BOULANGER on 24/01/2019.
//  Copyright © 2019 VBoulanger. All rights reserved.
//

import Foundation
import Alamofire

protocol RecipeProtocol {
	var recipes:Recipes {get set}
	var urlStringApi: String {get}
	func request(url: URL, completionHandler: @escaping (DataResponse<Any>) -> Void)// la fonction request va prendre en compte mon url et qui va me renvoyer un completion handler du même type que celui que te renvoie Alamofire (cf data response)
}
extension RecipeProtocol {
	
	
	var urlStringApi: String { // Je réécris la variable au dessus et lui attribue une valeur l'url en dessous
		let urlString = "https://api.yummly.com/v1/api/recipes?_app_id=654bf699&_app_key=7c4b6ee18b43f40b31fbd410264f2376&q="
		//let requiredPhoto:String = "&requirePictures=true"
		let recipeUser = String(recipes.ingredientsUserToUrl)
		print("recipeUser \(recipeUser)")
		let requestRecipe:String = urlString + recipeUser //+ requiredPhoto
		print("request Recipe :  \(requestRecipe)")
		
		return requestRecipe
	}
}
