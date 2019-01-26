//
//  UpdateItemViewController.swift
//  CoreDataExample
//
//  Created by Farhan Syed on 4/16/17.
//  Copyright © 2017 Farhan Syed. All rights reserved.
//

import UIKit

class ViewItemViewController: UIViewController, UITextViewDelegate {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var item: Item!

    @IBOutlet weak var descriptionView: UITextView!

    @IBOutlet weak var eventTypeLabel: UILabel!
    
    @IBAction func updateAction(_ sender: Any) {
        
//        guard let newEntry = entryText.text else  {
//            return
//        }
//
//        item.name = newEntry
//        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        dismiss(animated: true, completion: nil)
        
    }
    @IBOutlet weak var titleView: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
//        entryText!.delegate = self
//        entryText!.becomeFirstResponder()
        configureEntryData(entry: item)
        
        print(item)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configureEntryData(entry: Item) {
        
//        guard let text = entry.name else {
//            return
//        } change
        
        
        titleView.text = entry.name
        descriptionView.text = entry.desc
        eventTypeLabel.text = "\(entry.category ?? ""), \(entry.ownerEmail ?? ""), \(entry.longitude), \(entry.latitude)"
    }
    
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    
}
