//
//  ResultRecipesProtocol.swift
//  RecipleaseV1
//
//  Created by VINCENT BOULANGER on 27/01/2019.
//  Copyright © 2019 VBoulanger. All rights reserved.
//

import Foundation

protocol ResultRecipesProtocol {
	var id:String{get}
	var recipeName:String {get}
	var totalTimeInSeconds: Int {get}
	var rating :Int {get}
}


//let id: String
//let recipeName: String
//let smallImageUrls: [String]
//let totalTimeInSeconds: Int // transformer en string
//let ingredients: [String]
//let rating: Int
