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

class InstructionsCoreDataTestCase: XCTestCase {
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
	private func insertInstructions(into managedObjectContext: NSManagedObjectContext) {
		let instructions = Instruction(context: managedObjectContext)
		instructions.name = ""
		//recipeID.id = "The-BEST-Crockpot-Pot-Roast-2631670"
		
	}
	//MARK: - Unit Tests
	func testInsertManyRecipesInPersistentContainer() {
		for _ in 0 ..< 100000 {
			insertInstructions(into: mockContainer.newBackgroundContext())
		}
		XCTAssertNoThrow(try mockContainer.newBackgroundContext().save())
	}
	func testDeleteAllItemsInPersistentContainer() {
		insertInstructions(into: mockContainer.viewContext)
		try? mockContainer.viewContext.save()
		Instruction.deleteAll()
		XCTAssertEqual(Instruction.fetchAll(viewContext: mockContainer.viewContext ), [])
	}
	func testFetchAllItemsInPersistentContainer() {
		insertInstructions(into: mockContainer.viewContext)
		try? mockContainer.viewContext.save()
		XCTAssertEqual(Recipe.fetchAll(viewContext: mockContainer.viewContext), Instruction.all)
	}
}

