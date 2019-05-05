//
//  AppDelegate.swift
//  RecipleaseV1
//
//  Created by VINCENT BOULANGER on 11/12/2018.
//  Copyright © 2018 VBoulanger. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?


	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		// Override point for customization after application launch.
		return true
	}

	func applicationWillResignActive(_ application: UIApplication) {
		// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
		// Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
	}

	func applicationDidEnterBackground(_ application: UIApplication) {
		// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
		// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
	}

	func applicationWillEnterForeground(_ application: UIApplication) {
		// Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
	}

	func applicationDidBecomeActive(_ application: UIApplication) {
		// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
	}

	func applicationWillTerminate(_ application: UIApplication) {
		// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
		// Saves changes in the application's managed object context before the application terminates.
		self.saveContext()
	}

	// MARK: - Core Data stack

	lazy var persistentContainer: NSPersistentContainer = {
	    let container = NSPersistentContainer(name: "Reciplease") //  pour que notre NSPersistentContainer fasse son travail, à savoir créer les différents fichiers, initialiser le NSManagedObjectModel et le NSPersistentStoreCoordinator, il nous faut lui donner le nom de notre fichier
	    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
	        if let error = error as NSError? {
	            fatalError("Unresolved error \(error), \(error.userInfo)")
	        }
	    })
	    return container
	}()

	// MARK: - Core Data Saving support

	func saveContext () {
	    let context = persistentContainer.viewContext
	    if context.hasChanges {
	        do {
	            try context.save()
	        } catch {
	            let nserror = error as NSError
	            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
	        }
	    }
	}
	static var persistentContainer: NSPersistentContainer { // refactorisation accéder à notre propriété persistentContainer,
		guard let persistentContainer = UIApplication.shared.delegate as? AppDelegate else {return NSPersistentContainer()}
		return persistentContainer.persistentContainer
	}
	/*
	La dernière étape, c'est de récupérer le contexte puisque, comme on l'a vu au chapitre précédent, c'est dans le contexte que nous allons manipuler les données.
	
	Pour cela, nous allons tout simplement utiliser la propriété viewContext de type NSManagedObjectContext de la classe NSPersistentContainer. Cette propriété retourne un contexte à utiliser dans le Main Thread, celui dans lequel les vues sont gérées. D'où son nom.
	*/
	static var viewContext: NSManagedObjectContext { // recuperation du contexte
		return persistentContainer.viewContext
	}
}

