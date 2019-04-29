//
//  RecipeSession.swift
//  RecipleaseV1
//
//  Created by VINCENT BOULANGER on 24/01/2019.
//  Copyright © 2019 VBoulanger. All rights reserved.
//

import Foundation
import Alamofire

class RecipesSession: UrlYummlyConstructProtocol {
	
	// c'est ce qui remplace URL session
	func request(url: URL, completionHandler: @escaping (DataResponse<Any>) -> Void) {
		Alamofire.request(url).responseJSON { responseData in // alamofire request avec "url" que je passe en paramètre. je vais renvoyer ce que me renvoie alamofire dans mon completionHandler
			completionHandler(responseData)
		}
	}// en gros quand j'appelle request j'ai dans mon callback la reponse d'alamofire
}

