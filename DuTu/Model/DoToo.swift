//
//  DoToo.swift
//  DuTu
//
//  Created by Jeroen Dunselman on 29/01/2019.
//  Copyright © 2019 Jeroen Dunselman. All rights reserved.
//

import Foundation
import UIKit

class DoTooItem: NSObject {
    var data: Item!
//    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let categories = ["Sports", "Events", "Movies & Music", "Others"]
    
    init(item: Item) {
        self.data = item
    }
    
    func locality() -> String {
        if let locality = data.locality {
            return locality
        }
        return "No locality found"
    }
    
    func date() -> String {
        return describe(date: self.data.date_start!)
    }
    
    func text() -> String {
        var text = ""
        
        if let name = data.name {
            text = name
        } else {
            text = "name n.a."
        }
        
        if let desc = data.desc {
            text = "\(text), \(desc)"
        } else {
            text = "\(text), desc n.a."
        }
        
        return text
    }

    func detailText() -> String {
        let result = "\(locality()), \(date()), \(data.ownerEmail ?? "unowned")"
        return result
    }

}

extension DoTooItem {
    
    func describe(date: Date) -> String
    {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = DateFormatter.Style.short
        dateFormatter.timeStyle = DateFormatter.Style.short
        
        return dateFormatter.string(from: date)
    }
    

}
