//
//  Ingredient.swift
//  RecipleaseV1
//
//  Created by VINCENT BOULANGER on 14/03/2019.
//  Copyright © 2019 VBoulanger. All rights reserved.
//

import Foundation
import CoreData
class Ingredient: NSManagedObject {
	static var all: [Ingredient] {
		let request: NSFetchRequest<Ingredient> = Ingredient.fetchRequest()// création de la request Favorite. On précise entre les chevrons le type de résultat que va retourner notre requête. Comme pour un tableau, le type est incomplet si on ne fournit pas cette information.
		guard let ingredients = try? AppDelegate.viewContext.fetch(request) else {return []}
		return ingredients
	}
	static func fetchAll(viewContext: NSManagedObjectContext = AppDelegate.viewContext) -> [Ingredient] {
		let request: NSFetchRequest<Ingredient> = Ingredient.fetchRequest()
		guard let ingredients = try? AppDelegate.viewContext.fetch(request) else {return []}
		return ingredients
	}
	// function to deleta all favorites
	static func deleteAll() {
		let deleteRequest = NSBatchDeleteRequest(fetchRequest: Ingredient.fetchRequest())// le batch c'est pour tout supprimer
		let _ = try? AppDelegate.viewContext.execute(deleteRequest)
		// cf TP core data- git core data test
	}
}
