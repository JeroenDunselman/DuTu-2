//
//  CurrentUser.swift
//  DuTu
//
//  Created by Jeroen Dunselman on 20/01/2019.
//  Copyright © 2019 Jeroen Dunselman. All rights reserved.
//

import Foundation
import UIKit
import CoreData

public class CurrentUser {
    static let currentUser = CurrentUser()
    public var user: User?
    var filteredData: [User] = []
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    public init?() {    }
    
    func canSignIn(withEmail: String, password: String) -> Bool {
        if let user = subscription(withEmail: withEmail, password: password) {
            self.user = user
            return true
        }
        return false
    }
    
    func canSignUp(withEmail: String, password: String, firstName: String, lastName: String) -> Bool {
//        todoo check password length
        if subscription(withEmail: withEmail, password: password) != nil  {
            return false
        }
        
        let newSubscription = User(context: context)
        newSubscription.email = withEmail
        newSubscription.password = password
        newSubscription.firstname = firstName
        newSubscription.lastname = lastName
//        newSubscription.username = ""
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        user = newSubscription
        return true
    }
    
    func subscription(withEmail: String, password: String) -> User? {
        
        do {
            let fetchRequest : NSFetchRequest<User> = User.fetchRequest()
            
            let subscribedPredicate = NSPredicate(format: "(password == %@) AND (email = %@)", password, withEmail)
            fetchRequest.predicate = subscribedPredicate //NSPredicate(format: "publicItem == true")
            filteredData = try context.fetch(fetchRequest) //as! [Item]
            
            if filteredData.first != nil {
                
                return filteredData.first!
            }
        }
        catch {
            print ("fetch task failed", error)
        }
        
        return nil
    }
}
