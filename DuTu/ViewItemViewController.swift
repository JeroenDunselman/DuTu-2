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
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var item: Item!
    
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
    
    func configureEntryData(entry: Item) {
        
        titleView.text = entry.name
        var desc = ""
        if let description = entry.desc {
            desc = "\(description), "
        }
        descriptionView.text = "\(desc)\(entry.ownerEmail!)"
        let _ = geocode(latitude: entry.latitude, longitude: entry.longitude)
        eventTypeLabel.text = "\(describe(date: entry.date_start!) ), \(entry.category!)"
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}

extension ViewItemViewController {
    
    func describe(date: Date) -> String
    {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = DateFormatter.Style.short
        dateFormatter.timeStyle = DateFormatter.Style.short
        
        return dateFormatter.string(from: date)
    }
    
    func geocode(latitude: CLLocationDegrees, longitude: CLLocationDegrees) -> CLPlacemark? {
        
        let location = CLLocation(latitude: latitude, longitude: longitude)
        let geocoder = CLGeocoder()
        var placemark: CLPlacemark?
        
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            if error != nil {
                print("something went wrong")
            }
            
            if let placemarks = placemarks {
                placemark = placemarks.first
                self.locationLabel.text = placemark?.locality
            }
        }
        
        return placemark
    }
}

