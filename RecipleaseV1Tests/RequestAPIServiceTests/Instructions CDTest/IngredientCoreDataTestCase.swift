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

class IngredientCoreDataTestCase: XCTestCase {
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
	private func insertIngredient(into managedObjectContext: NSManagedObjectContext) {
		let ingredients = Ingredient(context: managedObjectContext)
		ingredients.name = ""
		
	}
	//MARK: - Unit Tests
	func testInsertManyRecipesInPersistentContainer() {
		for _ in 0 ..< 100000 {
			insertIngredient(into: mockContainer.newBackgroundContext())
		}
		XCTAssertNoThrow(try mockContainer.newBackgroundContext().save())
	}
	func testDeleteAllItemsInPersistentContainer() {
		insertIngredient(into: mockContainer.viewContext)
		try? mockContainer.viewContext.save()
		Ingredient.deleteAll()
		XCTAssertEqual(Ingredient.fetchAll(viewContext: mockContainer.viewContext ), [])
	}
	func testfetchAllIngredientInPersistentContainer () {
		insertIngredient(into: mockContainer.viewContext)
		try? mockContainer.viewContext.save()
		XCTAssertEqual(Recipe.fetchAll(viewContext: mockContainer.viewContext ), Ingredient.all)
	}
}

