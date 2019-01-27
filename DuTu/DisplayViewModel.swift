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
    var filteredData: [Item] = []
    let client: DisplayTableViewController?
    public var contentModeAll = true
    
    func fetchData() {
        
        do {
            let fetchRequest : NSFetchRequest<Item> = Item.fetchRequest()
            
            if contentModeAll {
                //public or owner = current
                fetchRequest.predicate = NSPredicate(format: "(publicItem == %@) OR (ownerEmail == %@)", NSNumber(booleanLiteral: true), (currentUser?.user?.email)!)
            } else {
                //owner = current
                fetchRequest.predicate = NSPredicate(format: "ownerEmail == %@", (currentUser?.user?.email)!)
            }
            
            filteredData = try context.fetch(fetchRequest)
        }
        catch {
            print ("fetch task failed", error)
        }
        
    }
    
    func data() -> [Item] {
        return filteredData
    }
    
    func newItem() -> Item {
        return Item(context: context)
    }
    
    func delete(forRow: Int) {
        let item = filteredData[forRow]
        self.context.delete(item)
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        self.filteredData.remove(at: forRow)
    }
    
    init(client: DisplayTableViewController) {
        self.client = client
    }
}
