//
//  FixerProtocol.swift
//  RecipleaseV1Tests
//
//  Created by VINCENT BOULANGER on 26/03/2019.
//  Copyright © 2019 VBoulanger. All rights reserved.
//

import Foundation
import Alamofire

protocol FixerProtocol {
	var urlStringApi: String {get}
	func request(url: URL, completionHandler: @escaping(DataResponse<Any>)-> Void)
}

extension FixerProtocol {
	var urlStringApiDetail:String {
		let urlStringRecipeDetail = "https://api.yummly.com/v1/api/recipe/The-BEST-Crockpot-Pot-Roast-2631670?_app_id=654bf699&_app_key=7c4b6ee18b43f40b31fbd410264f2376"
		return urlStringRecipeDetail
	}
	var urlStringApi:String {
		let urlStringApi = "https://api.yummly.com/v1/api/recipes?_app_id=654bf699&_app_key=7c4b6ee18b43f40b31fbd410264f2376&allowedIngredient[]=soup&allowedIngredient[]=onion"
		return urlStringApi
	}
}
