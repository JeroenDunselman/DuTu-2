//
//  CRUD.swift
//  DuTu
//
//  Created by Jeroen Dunselman on 19/01/2019.
//  Copyright © 2019 Jeroen Dunselman. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CRUD {
    
    func createData(){
        
        
        //        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        
        //We need to create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //Now let’s create an entity and new user records.
//        let userEntity = NSEntityDescription.entity(forEntityName: "User", in: managedContext)!
        let itemEntity = NSEntityDescription.entity(forEntityName: "Item", in: managedContext)!
        //final, we need to add some data to our newly created record for each keys using
        //here adding 5 data with loop
        
        for i in 1...2 {
            
//            let user = NSManagedObject(entity: userEntity, insertInto: managedContext)
//            user.setValue("Ankur\(i)", forKeyPath: "username")
//            user.setValue("ankur\(i)@test.com", forKey: "email")
//            user.setValue("ankur\(i)", forKey: "password")
            
            let item = NSManagedObject(entity: itemEntity, insertInto: managedContext)
            item.setValue("Ankur\(i)", forKeyPath: "name")
            item.setValue("ankur\(i)@test.com", forKey: "desc")
//            item.setValue("ankur\(i)", forKey: "password")
        }
        
        //Now we have set all the values. The next step is to save them inside the Core Data
        
        do {
            try managedContext.save()
            
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func retrieveData() {
        
        //As we know that container is set up in the AppDelegates so we need to refer that container.
        //        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //We need to create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //Prepare the request of type NSFetchRequest  for the entity
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        
        //        fetchRequest.fetchLimit = 1
        //        fetchRequest.predicate = NSPredicate(format: "username = %@", "Ankur")
        //        fetchRequest.sortDescriptors = [NSSortDescriptor.init(key: "email", ascending: false)]
        //
        do {
            let result = try managedContext.fetch(fetchRequest)
            for data in result as! [NSManagedObject] {
                print("\(Date()) \(data.value(forKey: "username") as! String)")
            }
            
        } catch {
            
            print("Failed")
        }
    }
    
    func updateData(){
        
        //As we know that container is set up in the AppDelegates so we need to refer that container.
        //        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //We need to create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "User")
        fetchRequest.predicate = NSPredicate(format: "username = %@", "Ankur1")
        do
        {
            let test = try managedContext.fetch(fetchRequest)
            
            let objectUpdate = test[0] as! NSManagedObject
            objectUpdate.setValue("newName", forKey: "username")
            objectUpdate.setValue("newmail", forKey: "email")
            objectUpdate.setValue("newpassword", forKey: "password")
            do{
                try managedContext.save()
            }
            catch
            {
                print(error)
            }
        }
        catch
        {
            print(error)
        }
        
    }
    
    func deleteData(){
        
        //As we know that container is set up in the AppDelegates so we need to refer that container.
        //        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //We need to create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        fetchRequest.predicate = NSPredicate(format: "username = %@", "Ankur3")
        
        do
        {
            let test = try managedContext.fetch(fetchRequest)
            
            let objectToDelete = test[0] as! NSManagedObject
            managedContext.delete(objectToDelete)
            
            do{
                try managedContext.save()
            }
            catch
            {
                print(error)
            }
            
        }
        catch
        {
            print(error)
        }
    }
    
}
extension CRUD {
    var appDelegate:AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
}
