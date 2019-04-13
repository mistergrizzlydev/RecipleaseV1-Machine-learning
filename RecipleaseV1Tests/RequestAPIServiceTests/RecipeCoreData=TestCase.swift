//
//  CoreDataTestCase.swift
//  RecipleaseV1Tests
//
//  Created by VINCENT BOULANGER on 27/03/2019.
//  Copyright © 2019 VBoulanger. All rights reserved.
//

import Foundation

import XCTest
import CoreData
@testable import RecipleaseV1

class RecipeCoreDataTestCase: XCTestCase {
	//MARK: - Properties
	lazy var mockContainer: NSPersistentContainer = {
		let container = NSPersistentContainer(name: "Reciplease")
		container.persistentStoreDescriptions[0].url = URL(fileURLWithPath: "/dev/null")
		container.loadPersistentStores(completionHandler: { (description, error) in
			XCTAssertNil(error)
		})
		return container
	}()
	//MARK: - Helper Methods
	private func insertRecipe(into managedObjectContext: NSManagedObjectContext) {
		let recipe = Recipe(context: managedObjectContext)
		recipe.id = "The-BEST-Crockpot-Pot-Roast-2631670"
		
	}
	private func insertNoTextData(into managedObjectContext: NSManagedObjectContext) {
		let recipe2 = Recipe(context: managedObjectContext)
		recipe2.id = "No text data"
		
	}
	//MARK: - Unit Tests
	func testInsertManyRecipesInPersistentContainer() {
		for _ in 0 ..< 10000 {
			insertRecipe(into: mockContainer.newBackgroundContext())
		}
		XCTAssertNoThrow(try mockContainer.newBackgroundContext().save())
	}
	func testDeleteAllItemsInPersistentContainer() {
		insertRecipe(into: mockContainer.viewContext)
		try? mockContainer.viewContext.save()
		Recipe.deleteAll()
		XCTAssertEqual(Recipe.fetchAll(viewContext: mockContainer.viewContext ), [])
	}
	func testFetchAllItemsInPersistentContainer() {
		insertRecipe(into: mockContainer.viewContext)
		try? mockContainer.viewContext.save()
		XCTAssertEqual(Recipe.fetchAll(viewContext: mockContainer.viewContext) , Recipe.all)
	}
	func testCheckIDfavorite() {
		insertRecipe(into: mockContainer.viewContext)
		try? mockContainer.viewContext.save()
		if Recipe.checkFavoriteID(id: "The-BEST-Crockpot-Pot-Roast-2631670") {
			XCTAssertEqual(Recipe.checkFavoriteID(id: "The-BEST-Crockpot-Pot-Roast-2631670", viewContext: mockContainer.viewContext), true)
		}
		
	}
	func testDeleteIDfavorite() {
		insertNoTextData(into: mockContainer.viewContext)
		try? mockContainer.viewContext.save()
		
		if Recipe.checkFavoriteID(id: "The-BEST-Crockpot-Pot-Roast-2631670") {
			Recipe.deleteFavoriteID(id: "The-BEST-Crockpot-Pot-Roast-2631670")
			XCTAssertEqual(Recipe.checkFavoriteID(id: "The-BEST-Crockpot-Pot-Roast-2631670", viewContext: mockContainer.viewContext), false)
		}
	}
}
//static var all: [Recipe] {
//	let request: NSFetchRequest<Recipe> = Recipe.fetchRequest()// création de la request Recipe. On précise entre les chevrons le type de résultat que va retourner notre requête. Comme pour un tableau, le type est incomplet si on ne fournit pas cette information.
//	guard let recipes = try? AppDelegate.viewContext.fetch(request) else {return []}
//	return recipes
//}


//static func fetchRecipe (id: String, viewContext: NSManagedObjectContext = AppDelegate.viewContext) -> [Recipe] {
//	let request: NSFetchRequest<Recipe> = Recipe.fetchRequest()
//	request.predicate = NSPredicate(format: "id == %@", id)
//	guard let recipes = try? viewContext.fetch(request) else {return []}
//	return recipes
//}

//// fonction qui delete une recette en fonction de son id
//static func deleteFavoriteID(id: String, viewContext: NSManagedObjectContext = AppDelegate.viewContext) {
//	let request: NSFetchRequest<Recipe> = Recipe.fetchRequest()
//	request.predicate = NSPredicate(format: "id == %@", id)
//	guard let recipes = try? viewContext.fetch(request) else {return} // je récupère un tableau avec une seule valeur  avec le filtre que j'ai appliqué ligne 30. on execute la requete avec le predicate
//	guard let recipe = recipes.first else {return}// on verifie qu'il contient bien une entrée et si oui on la met dans "recipe"
//	viewContext.delete(recipe) // on delete dans CoreData
//	/// on sauve l'opération dans CoreData
//}

