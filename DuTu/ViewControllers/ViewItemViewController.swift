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
    
    //    @IBOutlet weak var titleView: UILabel!
    @IBOutlet weak var descriptionView: UITextView!
    @IBOutlet weak var eventTypeLabel: UILabel!

    @IBOutlet weak var categoryLabel: UILabel!
    
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var weatherIconView: UIImageView!
    @IBAction func dismissView(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //        getWeather()
        configureEntryData(entry: item)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func clearLabels() {
        descriptionView.text = ""
        eventTypeLabel.text = ""
        categoryLabel.text = ""
    }
    
    func configureEntryData(entry: DoTooItem) {
        clearLabels()
        
        var desc = ""
        if let description = entry.data.desc {
            desc = "\(description)\n "
        }
        descriptionView.text = "\(desc) \n Submitted by \(entry.data.ownerEmail!)"
        
        desc = "\(entry.period())"
        eventTypeLabel.text = desc
        self.categoryLabel.text = "In \(entry.data.category!) category"
        if let _ = entry.data.locality {
            
            let today = day(date: Date())
            if let lastUpdate = item.data.weather_update {
                if day(date: lastUpdate) != today {
                    entry.getWeather(view: self)
                } else {
                    showWeather()
                }
            } else {
                entry.getWeather(view: self)
            }
        }
    }
    
    func day(date: Date) -> String {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = DateFormatter.Style.short
        return dateFormatter.string(from: date)
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}

extension ViewItemViewController:  WeatherView {
    
    func weatherDataAvailable() {
        
        item.weatherUpdate()
        showWeather()
    }
    
    func showWeather() {
        self.weatherLabel.text = "\(self.item.data.locality!) \(self.item.temperature)"
        let imageName = self.item.weather.iconNameFor(id: Int(self.item.data.forecast_weather_type))
        
        let image = UIImage(named: imageName)
        self.weatherIconView.image = image
    }
}
