//
//  CoreDataStack.swift
//  SenlaTennis
//
//  Created by Nikita Korolev on 18.02.2020.
//  Copyright © 2020 Никита Королев. All rights reserved.
//

import Foundation
import CoreData

final class CoreDataStack {
    
    static let shared = CoreDataStack(modelName: "SenlaTennis")
    
    private let modelName: String
    
    init(modelName: String) {
        self.modelName = modelName
    }

    private lazy var managedObjectModel: NSManagedObjectModel = {

        guard let modelURL = Bundle.main.url(forResource: self.modelName, withExtension: "momd") else {
            fatalError("Unable to Find Data Model")
        }

        guard let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Unable to Load Data Model")
        }

        return managedObjectModel
    }()
    
    lazy var storeContainer: NSPersistentContainer = {

      let container = NSPersistentContainer(name: self.modelName)
      container.loadPersistentStores { (storeDescription, error) in
        if let error = error as NSError? {
          fatalError("Unresolved error \(error), \(error.userInfo)")
        }
      }

      return container
    }()

    private lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {

        let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)

        let fileManager = FileManager.default
        let storeName = "\(self.modelName).sqlite"

        let documentsDirectoryURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]

        let persistentStoreURL = documentsDirectoryURL.appendingPathComponent(storeName)

        do {
            let options = [
                NSMigratePersistentStoresAutomaticallyOption : true,
                NSInferMappingModelAutomaticallyOption : false
            ]

            // Add Persistent Store
            try persistentStoreCoordinator.addPersistentStore(ofType: NSSQLiteStoreType,
                                                              configurationName: nil,
                                                              at: persistentStoreURL,
                                                              options: options)

        } catch {
            fatalError("Unable to Add Persistent Store")
        }

        return persistentStoreCoordinator
    }()

    public private(set) lazy var managedContext: NSManagedObjectContext = {

        let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)

        managedObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator

        return managedObjectContext
    }()
    
    public private(set) lazy var childManagedContext: NSManagedObjectContext = {

        let managedObjectContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        managedObjectContext.parent = self.managedContext

        return managedObjectContext
    }()
    
    func saveContext() {
        
        guard managedContext.hasChanges else { return }

        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
    }
    
    func saveContextInBackground() {

        childManagedContext.perform {
            guard self.childManagedContext.hasChanges else { return }

            do {
                try self.childManagedContext.save()
                self.managedContext.performAndWait {
                    do {
                        try self.managedContext.save()
                    } catch let error as NSError {
                        print("Unresolved error \(error), \(error.userInfo)")
                    }
                }
            } catch let error as NSError {
                print("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
}

extension CoreDataStack {
    func getDepartments(completionHandler: @escaping ([Department]) -> ()) {
        let departmentFetch: NSFetchRequest<Department> = Department.fetchRequest()
        
        do {
            let results = try childManagedContext.fetch(departmentFetch)
            if results.count > 0 {
                completionHandler(results)
            }
        } catch let error as NSError {
            print("Fetch error: \(error) description: \(error.userInfo)")
        }
    }
    
    func getDepartmentsEmployees(departmentName: String, completionHandler: @escaping ([Employee]?, Bool) -> ()) {
        let employeesFetch: NSFetchRequest<Employee> = Employee.fetchRequest()
        employeesFetch.predicate = NSPredicate(format: "%K == %@",#keyPath(Employee.department.name), departmentName)
        
        do {
            let results = try childManagedContext.fetch(employeesFetch)
            if results.count > 0 {
                completionHandler(results, true)
            } else {
                completionHandler(nil,false)
            }
        } catch let error as NSError {
            print("Fetch error: \(error) description: \(error.userInfo)")
        }
    }
    
    func getGames() -> [Game] {
        let gameFetch: NSFetchRequest<Game> = Game.fetchRequest()
        
        do {
            let results = try childManagedContext.fetch(gameFetch)
            if results.count > 0 {
                return results
            }
        } catch let error as NSError {
            print("Fetch error: \(error) description: \(error.userInfo)")
        }
        return []
    }
    
    func deleteGame(game: Game) {
        childManagedContext.delete(game)
        saveContextInBackground()
    }
    
    func checkIsRepeated(name: String, department: String, completion: @escaping ((Bool) -> ())) {
        var currentDepartment: Department?
        let departmentFetch: NSFetchRequest<Department> = Department.fetchRequest()
        departmentFetch.predicate = NSPredicate(format: "%K == %@",#keyPath(Department.name), department)
        
        do {
            let results = try childManagedContext.fetch(departmentFetch)
            if results.count > 0 {
                debugPrint("Такой отдел уже есть, ищем в нем сотрудника...")
                currentDepartment = results.first
            } else {
                currentDepartment = Department(context: childManagedContext)
                currentDepartment?.name = department
            }
            
            let employeeFetch: NSFetchRequest<Employee> = Employee.fetchRequest()
            employeeFetch.predicate = NSCompoundPredicate(type: .and, subpredicates: [
                NSPredicate(format: "%K == %@",#keyPath(Employee.name), name),
                NSPredicate(format: "%K == %@",#keyPath(Employee.department.name), currentDepartment!.name!)
            ])
            
            do {
                let results = try childManagedContext.fetch(employeeFetch)
                if results.count > 0 {
                    debugPrint("В данном отделе есть сотрудник с таким именем. Надо изменить имя")
                    completion(true)
                } else {
                    let employee = Employee(context: childManagedContext)
                    employee.name = name
                    if let department = currentDepartment,
                        let employees = department.people?.mutableCopy() as? NSMutableOrderedSet {
                        employees.add(employee)
                        department.people = employees
                    }
                    saveContextInBackground()
                    completion(false)
                }
            } catch let error as NSError {
                print("Fetch error: \(error) description: \(error.userInfo)")
            }
        } catch let error as NSError {
            print("Fetch error: \(error) description: \(error.userInfo)")
        }
    }
    
    func gameIsOver(firstScore: Int, secondScore: Int, players: [Employee]) {
        let game = Game(context: childManagedContext)
        game.date = Date()
        game.firstScore = Int32(firstScore)
        game.secondScore = Int32(secondScore)
        for player in players {
            player.addToGames(game)
            game.addToPlayers(player)
        }
        saveContextInBackground()
    }
}
