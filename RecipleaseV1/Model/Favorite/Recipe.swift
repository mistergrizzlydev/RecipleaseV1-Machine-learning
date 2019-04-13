//
//  Favorites.swift
//  RecipleaseV1
//
//  Created by VINCENT BOULANGER on 04/03/2019.
//  Copyright © 2019 VBoulanger. All rights reserved.
//

import Foundation
import CoreData

class Recipe: NSManagedObject {
	
	static var all: [Recipe] {
		let request: NSFetchRequest<Recipe> = Recipe.fetchRequest()// création de la request Recipe. On précise entre les chevrons le type de résultat que va retourner notre requête. Comme pour un tableau, le type est incomplet si on ne fournit pas cette information.
		guard let recipes = try? AppDelegate.viewContext.fetch(request) else {return []}
		return recipes
	}
	static func fetchAll(viewContext: NSManagedObjectContext = AppDelegate.viewContext) -> [Recipe] {
		let request: NSFetchRequest<Recipe> = Recipe.fetchRequest()
		guard let recipes = try? AppDelegate.viewContext.fetch(request) else {return []}
		return recipes
	}
	
	// faire une func qui check si une recette est présente avec son ID -> renvoie true ou false
	static func checkFavoriteID(id: String, viewContext: NSManagedObjectContext = AppDelegate.viewContext) -> Bool {
		let request: NSFetchRequest<Recipe> = Recipe.fetchRequest()
		request.predicate = NSPredicate(format: "id == %@", id)
		guard let recipes = try? viewContext.fetch(request) else {return false} // je récupère un tableau avec une seule valeur avec le filtre que j'ai appliqué ligne 30
		if recipes.isEmpty { // je viens vérifier qu'il y a bien une valeur dans le tableau et je renvois faux
			return false
		}
		return true
	}
	static func fetchRecipe (id: String, viewContext: NSManagedObjectContext = AppDelegate.viewContext) -> [Recipe] {
		let request: NSFetchRequest<Recipe> = Recipe.fetchRequest()
		request.predicate = NSPredicate(format: "id == %@", id)
		guard let recipes = try? viewContext.fetch(request) else {return []}
		return recipes
	}
	
	// fonction qui delete une recette en fonction de son id
	static func deleteFavoriteID(id: String, viewContext: NSManagedObjectContext = AppDelegate.viewContext) {
		let request: NSFetchRequest<Recipe> = Recipe.fetchRequest()
		request.predicate = NSPredicate(format: "id == %@", id)
		guard let recipes = try? viewContext.fetch(request) else {return} // je récupère un tableau avec une seule valeur  avec le filtre que j'ai appliqué ligne 30. on execute la requete avec le predicate
		guard let recipe = recipes.first else {return}// on verifie qu'il contient bien une entrée et si oui on la met dans "recipe"
		viewContext.delete(recipe) // on delete dans CoreData
		 /// on sauve l'opération dans CoreData
	}
	// function to deleta all favorites
	static func deleteAll() {
		let deleteRequest = NSBatchDeleteRequest(fetchRequest: Recipe.fetchRequest())// le batch c'est pour tout supprimer
		let _ = try? AppDelegate.viewContext.execute(deleteRequest)
		// cf TP core data- git core data test
	}
}
