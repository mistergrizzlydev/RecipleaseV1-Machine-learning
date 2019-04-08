//
//  RecipeProtocol.swift
//  RecipleaseV1
//
//  Created by VINCENT BOULANGER on 24/01/2019.
//  Copyright © 2019 VBoulanger. All rights reserved.
//

import Foundation
import Alamofire

protocol UrlYummlyConstructProtocol {
	
	var urlStringApi:String {get}
	var urlStringApiDetail:String {get}
	var appId:String {get}
	var appKey:String {get}
	func request(url: URL, completionHandler: @escaping (DataResponse<Any>) -> Void)// la fonction request va prendre en compte mon url et qui va me renvoyer un completion handler du même type que celui que renvoie Alamofire (cf data response)
}
extension UrlYummlyConstructProtocol {
	var urlStringApi: String { // Je réécris la variable au dessus et lui attribue une valeur l'url en dessous
		let urlRecipeList = "https://api.yummly.com/v1/api/recipes?"
		return urlRecipeList
	}
	var urlStringApiDetail :String {
		let urlRecipeIngredient = "https://api.yummly.com/v1/api/recipe/"
		return urlRecipeIngredient
	}
	var appId:String {
		return "654bf699"
	}
	var appKey:String {
		return "7c4b6ee18b43f40b31fbd410264f2376"
	}
}


