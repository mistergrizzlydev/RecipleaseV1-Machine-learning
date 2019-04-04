//
//  Instructions.swift
//  RecipleaseV1
//
//  Created by VINCENT BOULANGER on 10/03/2019.
//  Copyright © 2019 VBoulanger. All rights reserved.
//

import Foundation
import CoreData
class Instruction: NSManagedObject {
	static var all: [Instruction] {
		let request: NSFetchRequest<Instruction> = Instruction.fetchRequest()// création de la request Favorite. On précise entre les chevrons le type de résultat que va retourner notre requête. Comme pour un tableau, le type est incomplet si on ne fournit pas cette information.
		guard let instructions = try? AppDelegate.viewContext.fetch(request) else {return []}
		return instructions
	}
	static func fetchAll(viewContext: NSManagedObjectContext = AppDelegate.viewContext) -> [Instruction] {
		let request: NSFetchRequest<Instruction> = Instruction.fetchRequest()
		guard let instructions = try? AppDelegate.viewContext.fetch(request) else {return []}
		return instructions
	}
	
}
