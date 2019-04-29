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
	//MARK: - Unit Tests
	func testInsertManyRecipesInPersistentContainer() {
		for _ in 0 ..< 10000 {
			insertRecipe(into: mockContainer.newBackgroundContext())
		}
		XCTAssertNoThrow(try mockContainer.newBackgroundContext().save())
	}
	func testDeleteAllItemsInPersistentContainer() {
		insertRecipe(into: mockContainer.viewContext)
		Recipe.deleteAll()
		XCTAssertEqual(Recipe.fetchAll(viewContext: mockContainer.viewContext ), [])
	}
	func testFetchAllItemsInPersistentContainer() {
		insertRecipe(into: mockContainer.viewContext)
		XCTAssertEqual(Recipe.fetchAll(viewContext: mockContainer.viewContext), Recipe.all)
	}
	func testCheckIDfavorite() {
		insertRecipe(into: mockContainer.viewContext)
		XCTAssertEqual(Recipe.checkFavoriteID(id: "The-BEST-Crockpot-Pot-Roast-2631670", viewContext: mockContainer.viewContext) , true)
	}
	func testCheckBadIDfavorite() {
		XCTAssertEqual(Recipe.checkFavoriteID(id: "", viewContext: mockContainer.viewContext) , false)
	}
	
	func testDeleteIDfavorite() {
		insertRecipe(into: mockContainer.viewContext)
		// save
		try? mockContainer.viewContext.save()
		Recipe.deleteFavoriteID(id: "The-BEST-Crockpot-Pot-Roast-2631670")
		XCTAssertEqual(Recipe.checkFavoriteID(id: "The-BEST-Crockpot-Pot-Roast-2631670", viewContext: mockContainer.viewContext), true)
	}
	func testDeleteIDfavoriteCD() {
		insertRecipe(into: mockContainer.viewContext)
		Recipe.deleteFavoriteID(id: "The-BEST-Crockpot-Pot-Roast-2631670")
		XCTAssertEqual(Recipe.all.first, nil)
	}
	func testFetchRecipe() {
		insertRecipe(into: mockContainer.viewContext)
		let fetch = Recipe.fetchRecipe(id: "", viewContext: mockContainer.viewContext)
		XCTAssertEqual(fetch, Recipe.all)
	}
}
