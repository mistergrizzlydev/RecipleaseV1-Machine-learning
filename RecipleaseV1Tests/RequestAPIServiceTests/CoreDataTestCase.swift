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

class CoreDataTestCase: XCTestCase {
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
		let recipeID = Recipe(context: managedObjectContext)
		recipeID.id = "The-BEST-Crockpot-Pot-Roast-2631670"
		
	}
	//MARK: - Unit Tests
	func testInsertManyRecipesInPersistentContainer() {
		for _ in 0 ..< 100000 {
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
}
