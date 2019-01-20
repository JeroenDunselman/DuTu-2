//
//  DisplayViewModel.swift
//  DuTu
//
//  Created by Jeroen Dunselman on 19/01/2019.
//  Copyright © 2019 Jeroen Dunselman. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class DisplayViewModel {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var items: [Item] = []
//    var selectedIndex: Int!
    var filteredData: [Item] = []
    let client: DisplayTableViewController?
    public var contentModeAll = true
    
    func fetchData() {
        do {
            let fetchRequest : NSFetchRequest<Item> = Item.fetchRequest()
            
//        let namesBeginningWithLetterPredicate = NSPredicate(format: "(firstName BEGINSWITH[cd] $letter) OR (lastName BEGINSWITH[cd] $letter)")

            if contentModeAll {
                //public or owner = current
                fetchRequest.predicate = NSPredicate(format: "(publicItem == %@) OR (ownerEmail == %@)", NSNumber(booleanLiteral: true), (currentUser?.user?.email)!)
            } else {
                //owner = current
                fetchRequest.predicate = NSPredicate(format: "ownerEmail == %@", (currentUser?.user?.email)!)
            }
            
            
            filteredData = try context.fetch(fetchRequest) //as! [Item]
//            if let aContact = fetchedResults.first {
//                providerName.text = aContact.providerName
//            }
        }
        catch {
            print ("fetch task failed", error)
        }
//        do {
//            items = try context.fetch(Item.fetchRequest())
//            items.predicate = NSPredicate(format: "public == %@", true)
//            filteredData = items
//            DispatchQueue.main.async {
////                self.tableView.reloadData()
//            }
//        } catch {
//            print("Couldn't Fetch Data")
//        }
        
    }
    
    func data() -> [Item] {
        return filteredData
    }
    func newItem() -> Item {
        return Item(context: context)
    }
    init(client: DisplayTableViewController) {
        self.client = client
    }
}
