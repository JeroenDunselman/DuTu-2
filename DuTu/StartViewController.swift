//
//  StartViewController.swift
//  Snapchat Camera
//
//  Created by ashika shanthi on 2/27/18.
//  Copyright © 2018 ashika shanthi. All rights reserved.
//

import UIKit

let currentUser = CurrentUser()
class StartViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if (currentUser?.user) != nil {
            self.performSegue(withIdentifier: "alreadyLoggedIn", sender: nil)
        }
    }
}
