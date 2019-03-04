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

class Favorites: NSManagedObject {
	
	static func fetchAll(viewContext: NSManagedObjectContext = AppDelegate.viewContext ) -> [Favorite] {
		let request: NSFetchRequest<Favorite> = Favorite.fetchRequest()
		request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true),NSSortDescriptor(key: "id", ascending: true)]
		guard let myFavorites = try? AppDelegate.viewContext.fetch(request) else {return []}
		return myFavorites
	}
	static func deleteAll() {
		let deleteRequest = NSBatchDeleteRequest(fetchRequest: Favorite.fetchRequest())
		let _ = try? AppDelegate.viewContext.execute(deleteRequest)
	}
}
