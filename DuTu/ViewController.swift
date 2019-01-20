//
//  ViewController.swift
//  DuTu
//
//  Created by Jeroen Dunselman on 19/01/2019.
//  Copyright © 2019 Jeroen Dunselman. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
let crud = CRUD()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        crud.retrieveData()
        crud.createData()
    }
    
    
}

