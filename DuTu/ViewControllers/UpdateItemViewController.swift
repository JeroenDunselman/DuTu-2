//
//  addItemViewController.swift
//  CoreDataExample
//
//  Created by Farhan Syed on 4/16/17.
//  Copyright © 2017 Farhan Syed. All rights reserved.
//

import UIKit
import MapKit

class UpdateItemViewController: UIViewController, UITextViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    
    let categories = ["Sports", "Events", "Movies & Music", "Others"]
    var selectedCategory = 0
    public var isAdding: Bool = false
    
    var item: DoTooItem!
    var location: DoTooLocation?
    
    @IBOutlet weak var descriptionTextView: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet var itemEntryTextView: UITextView?
    @IBOutlet weak var privacyControl: UISegmentedControl!
    @IBOutlet weak var buttonSave: UIButton!
    @IBOutlet weak var categoryPicker: UIPickerView!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBAction func saveContact(_ sender: Any) {
        
        if let item = item {
            item.data.ownerEmail = currentUser?.user?.email
            item.data.name = itemEntryTextView?.text!
            item.data.publicItem = self.privacyControl.selectedSegmentIndex == 0
            item.data.category = categories[selectedCategory]
            item.data.desc = descriptionTextView?.text!
            if let location = location {
                item.data.latitude = location.coordinate.latitude
                item.data.longitude = location.coordinate.longitude
                item.data.locality = location.locality
            }
            
            item.data.date_start = datePicker.date
            //                item.date_end
           
            do {
                try item.data.validateForInsert()

            } catch {
                let validationError = error as NSError
                
                print(validationError)
                
                let alert = UIAlertController(title: validationError.localizedDescription, message: validationError.localizedDescription, preferredStyle: .alert)
                
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alert.addAction(defaultAction)
                self.present(alert, animated: true, completion: nil)
                self.dismiss(animated: true, completion: nil)
            }
            
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            dismiss(animated: true, completion: nil)
            
        }
        
    }
    @IBOutlet weak var localityLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        itemEntryTextView?.delegate = self
        self.categoryPicker.dataSource = self
        self.categoryPicker.delegate = self
        initMap()
    }
    
    override func viewWillAppear(_ animated: Bool)    {
        
        if let item = item {
            itemEntryTextView?.text = item.data.name
            descriptionTextView.text = item.data.desc
            
            privacyControl.selectedSegmentIndex = item.data.publicItem ? 0 : 1
            if let category = item.data.category {
                categoryPicker.selectRow(categories.firstIndex(of: category)! , inComponent:0, animated:true)
            }
            
            showLocation(ForItem: item.data)
        }
        
        let title = isAdding ? "Add" : "Update"
        buttonSave.setTitle(title, for: .normal)
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
}

extension UpdateItemViewController {
    
    @objc func handleLongPress(_ gestureRecognizer : UIGestureRecognizer){
        if gestureRecognizer.state != .began { return }
        
        let touchPoint = gestureRecognizer.location(in: mapView)
        let touchMapCoordinate = mapView.convert(touchPoint, toCoordinateFrom: mapView)
        if let location = self.location {
            mapView.removeAnnotation(location)
        }
        self.location = DoTooLocation(coordinate: touchMapCoordinate, label: self.localityLabel)
        
        mapView.addAnnotation(self.location!)
    }
    
    func showLocation(ForItem: Item) {
        var lat: Double
        var long: Double
        
        if isAdding && ((self.item.data.longitude == 0 && self.item.data.latitude == 0) || self.location == nil)
        {
            long = 4.4684
            lat = 51.9230
        } else {
            long = item.data.longitude
            lat = item.data.latitude
        }
        
        if let location = self.location {
            mapView.removeAnnotation(location)
        }
        
        let location = CLLocationCoordinate2D(latitude: lat, longitude: long)
        self.location = DoTooLocation(coordinate: location, label: nil)
    
        self.localityLabel.text = self.item.data.locality
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
        mapView.addAnnotation(self.location!)
    }
    
    func initMap() {
        let longPressRecogniser = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))//MapViewController.
        longPressRecogniser.minimumPressDuration = 1.0
        
        mapView.addGestureRecognizer(longPressRecogniser)
        mapView.mapType = MKMapType.standard
    }
    
}

extension UpdateItemViewController {
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
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

