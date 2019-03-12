//
//  Favorites.swift
//  RecipleaseV1
//
//  Created by VINCENT BOULANGER on 04/03/2019.
//  Copyright © 2019 VBoulanger. All rights reserved.
//

import Foundation
import CoreData

//class Recipe: NSManagedObject {
//
//}

//class Favorite {
//	var id: String = ""
//	var name: String = ""
//	var totalTime: String = ""
//	var rate: String = ""
//	var imageData:String = ""
//}

class Favorite: NSManagedObject {
	
	static var all: [Favorite] {
		let request: NSFetchRequest<Favorite> = Favorite.fetchRequest()// création de la request Favorite. On précise entre les chevrons le type de résultat que va retourner notre requête. Comme pour un tableau, le type est incomplet si on ne fournit pas cette information.
		guard let favorites = try? AppDelegate.viewContext.fetch(request) else {return []}
		return favorites
	}
	static func fetchAll(viewContext: NSManagedObjectContext = AppDelegate.viewContext ) -> [Favorite] {
		let request: NSFetchRequest<Favorite> = Favorite.fetchRequest()
		request.sortDescriptors = [NSSortDescriptor(key: "nameRecipe", ascending: true),
								   NSSortDescriptor(key: "idRecipe", ascending: true),
								   NSSortDescriptor(key: "totalTimeRecipe", ascending: true),
								   NSSortDescriptor(key: "rateRecipe", ascending: true),
								   NSSortDescriptor(key: "sourceRecipe", ascending: true),
								   NSSortDescriptor(key: "imageRecipe", ascending: true),
								   NSSortDescriptor(key: "instructions", ascending: true)
		]
		guard let myFavorites = try? AppDelegate.viewContext.fetch(request) else {return []}
		return myFavorites
	}
	static func deleteAll() {
		let deleteRequest = NSBatchDeleteRequest(fetchRequest: Favorite.fetchRequest())
		let _ = try? AppDelegate.viewContext.execute(deleteRequest)
	}
}

