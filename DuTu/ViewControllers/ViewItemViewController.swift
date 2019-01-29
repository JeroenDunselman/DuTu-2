//
//  UpdateItemViewController.swift
//  CoreDataExample
//
//  Created by Farhan Syed on 4/16/17.
//  Copyright © 2017 Farhan Syed. All rights reserved.
//

import UIKit
import CoreLocation

class ViewItemViewController: UIViewController, UITextViewDelegate {
    
    var item: DoTooItem!
    
    @IBOutlet weak var titleView: UILabel!
    @IBOutlet weak var descriptionView: UITextView!
    @IBOutlet weak var eventTypeLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBAction func dismissView(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureEntryData(entry: item)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func configureEntryData(entry: DoTooItem) {
        
        titleView.text = entry.data.name
        var desc = ""
        if let description = entry.data.desc {
            desc = "\(description), "
        }
        descriptionView.text = "\(desc)\(entry.data.ownerEmail!)"
        self.locationLabel.text = entry.data.locality
        eventTypeLabel.text = "\(entry.describe(date: entry.data.date_start!) ), \(entry.data.category!)"
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}

//extension ViewItemViewController {
//
//    func describe(date: Date) -> String
//    {
//        let dateFormatter = DateFormatter()
//
//        dateFormatter.dateStyle = DateFormatter.Style.short
//        dateFormatter.timeStyle = DateFormatter.Style.short
//
//        return dateFormatter.string(from: date)
//    }
//    
//}

