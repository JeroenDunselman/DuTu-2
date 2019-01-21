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
//        addGradient()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        if Auth.auth().currentUser != nil {
//            self.performSegue(withIdentifier: "alreadyLoggedIn", sender: nil)
//        }
        if (currentUser?.user) != nil { //(currentUser?.hasAccess())! {
            self.performSegue(withIdentifier: "alreadyLoggedIn", sender: nil)
        }
    }
}
//    var gradient: CAGradientLayer?
//    func addGradient() {
//        gradient = CAGradientLayer()
//        let startColor = UIColor(red: 167/255, green: 185/255, blue: 169/255, alpha: 1)
//        let endColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
//        gradient?.colors = [startColor.cgColor,endColor.cgColor]
//        gradient?.startPoint = CGPoint(x: 0, y: 0)
//        gradient?.endPoint = CGPoint(x: 0, y:1)
//        gradient?.frame = view.frame
//        self.view.layer.insertSublayer(gradient!, at: 0)
//    }

