//
//  Recipes.swift
//  RecipleaseV1
//
//  Created by VINCENT BOULANGER on 23/01/2019.
//  Copyright © 2019 VBoulanger. All rights reserved.
//

import Foundation
struct RecipesModel {
	var id:String // let
	var recipeName:String
	var smallImageUrls:[String]
	var totalTimeInSeconds:Int // transformer en string
	var ingredients:[String]
	var rating:Int
	var favorite:Bool // to use with favorites
}
