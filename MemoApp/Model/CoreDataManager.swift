//
//  CoreDataManager.swift
//  MemoApp
//
//  Created by 김대희 on 2021/07/27.
//

import CoreData
import SwiftUI

class CoreDataManager: ObservableObject {
    static let shared = CoreDataManager()
    private init () {}
    
    // MARK: - Core Data stack
    
    func AddMemo(content : String) {
        let newMemo = MemoEnity(context: Self.mainContext)
        newMemo.id = UUID()
        newMemo.contant = content
        newMemo.insertDate = Date()
        
        saveContext()
    }
    
    @FetchRequest (entity: MemoEnity.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \MemoEnity.insertDate, ascending: false)])
    
    var memoList : FetchedResults<MemoEnity>
    
    func upDate(memo : MemoEnity?, contant : String) {
        memo?.contant = contant
        saveContext()
    }
    func delete(memo : MemoEnity?) {
        if let memo = memo {
            Self.mainContext.delete(memo)
            saveContext()
        }
    }
    
    static var mainContext : NSManagedObjectContext {
        return persistentContainer.viewContext 
    }
    
    static  var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "MemoApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = Self.persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
