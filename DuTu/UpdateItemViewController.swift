//
//  addItemViewController.swift
//  CoreDataExample
//
//  Created by Farhan Syed on 4/16/17.
//  Copyright © 2017 Farhan Syed. All rights reserved.
//

import UIKit

class UpdateItemViewController: UIViewController, UITextViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    
    let categories = ["Sports", "Events", "Movies & Music", "Others"]
    var selectedCategory = 0
    public var isAdding: Bool = false
    
    var item: Item!
    @IBOutlet var itemEntryTextView: UITextView?
    @IBOutlet weak var privacyControl: UISegmentedControl!
    @IBOutlet weak var buttonSave: UIButton!
    @IBOutlet weak var categoryPicker: UIPickerView!
    
    @IBAction func saveContact(_ sender: Any) {
        
        if (itemEntryTextView?.text.isEmpty)! || itemEntryTextView?.text == "Type anything..."{
            print("No Data")
            
            let alert = UIAlertController(title: "Please Type Something", message: "Your entry was left blank.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .default) { action in
                
            })
            
            self.present(alert, animated: true, completion: nil)
            
        } else {

            if let item = item {
                item.ownerEmail = currentUser?.user?.email
                item.name = itemEntryTextView?.text!
                item.publicItem = self.privacyControl.selectedSegmentIndex == 0
                item.category = categories[selectedCategory]

            }
            
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            dismiss(animated: true, completion: nil)
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        itemEntryTextView?.delegate = self
        self.categoryPicker.dataSource = self
        self.categoryPicker.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool)    {
        let title = isAdding ? "Add" : "Update"
        
        if let item = item {
            itemEntryTextView?.text = item.name
            //            self.privacyControl.setTitle("Hatseflats", forSegmentAt: 0)
            self.privacyControl.selectedSegmentIndex = item.publicItem ? 0 : 1
            if let category = item.category {
                self.categoryPicker.selectRow(categories.firstIndex(of: category)! , inComponent:0, animated:true)
            }
        }
        
        buttonSave.setTitle(title, for: .normal)
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
        textView.textColor = UIColor.black
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
}

extension UpdateItemViewController {
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //        print("Row: \(row)")
        self.selectedCategory = row
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {

        return self.categories.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.categories[row]

    }
}
/*
 
 //            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
 //            guard let item = item else {
 //            if isAdding {
 
 //            }
 //            }
 //            } else {
 //                let newEntry = Item(context: context)
 //                newEntry.ownerEmail = currentUser?.user?.email
 //                newEntry.name = itemEntryTextView?.text!
 //                newEntry.publicItem = self.privacyControl.selectedSegmentIndex == 0
 //                newEntry.category = categories[selectedCategory]
 
 
 //    @IBAction func cancel(_ sender: Any) {
 //
 //        dismiss(animated: true, completion: nil)
 //    }
 //    if component == 0 {
 //        return "First \(row)"
 //    } else {
 //        return "Second \(row)"
 //    }
 //    if component == 0 {
 //        return 10
 //    } else {
 //        return 100
 //    }
*/
