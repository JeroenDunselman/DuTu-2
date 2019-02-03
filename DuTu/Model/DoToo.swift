//
//  DoToo.swift
//  DuTu
//
//  Created by Jeroen Dunselman on 29/01/2019.
//  Copyright © 2019 Jeroen Dunselman. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class DoTooItem: NSObject {
    
    var data: Item!
    let categories = ["Sports", "Events", "Movies & Music", "Others"]
    var weather = WeatherService()

    init(item: Item) {
        self.data = item
        if self.data.date_start == nil {
            self.data.date_start = Date()
        }
    }
    
    func locality() -> String {
        if let locality = data.locality {
            return locality
        }
        return "No locality found"
    }
    
    func period() -> String {
        var desc = "From \(describe(date: self.data.date_start!))"
        desc = desc + (endDate() == nil ? "" : " to \(endDate()!)")
        return desc
    }
    
    func date() -> String {
        return describe(date: self.data.date_start!)
    }
    
    func endDate() -> String? {
        if let date = data.date_end {
            return describe(date: date)
        }
        return nil
    }
    
    func text() -> String {
        
        var text = ""
        text = data.name == nil ? "name n.a." : data.name!
        text = text + (data.desc == nil ? ", desc n.a." : ", \(data.desc!)")
        
        return text
    }

    func detailText() -> String {
        let result = "\(locality()), \(date()), \(data.ownerEmail ?? "unowned")"
        return result
    }

    func getWeather(view: WeatherView) {
        
        let forecastDate = max(data.date_start!, Date())
        let index = dateIndex(for: forecastDate)
        if index > 16 { return }
        
        weather.view = view
        if let locality = data.locality {
            weather.location = locality
            weather.getCurrentWeatherData()
            weather.getForecastWeatherData()
        }

    }
    
    func getWeather() {
        let forecastDate = max(data.date_start!, Date())
        let index = dateIndex(for: forecastDate)
        if index > 16 { return }
        
        weather.view = self
        if let locality = data.locality {
            weather.location = locality
            weather.getCurrentWeatherData()
            weather.getForecastWeatherData()
        }
    }
    
    func weatherUpdate() {
    
        data.weather_update = Date()
        
        let forecastDate = max(data.date_start!, Date())
        let index = dateIndex(for: forecastDate)
        
        //forecast n.a.
        if index > weather.forecast.count {
            return
        }
        
        var temperature = ""
        var type = 0
        if index == 0 {
            temperature = weather.tempCurrent
            type = weather.weatherTypeCurrentId
        } else {
            temperature = weather.forecast[index - 1].max
            type = weather.forecast[index - 1].typeId
        }
        data.forecast_temperature = temperature
        data.forecast_weather_type = Double(type)
        
        do { try data.validateForInsert() } catch {
            return
        }
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    }
    
    var temperature: String {
        if let temp = self.data.forecast_temperature {
            return "\(temp) °"
        }
        return ""
    }
    
    func dateIndex(for forecastDate: Date) -> Int {
        let calendar = Calendar.current
        // Replace the hour (time) of both dates with 00:00
        let date1 = calendar.startOfDay(for: Date())
        let date2 = calendar.startOfDay(for: forecastDate)
        let dateIndex = calendar.dateComponents([.day], from: date1, to: date2).day!
        return dateIndex
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

extension DoTooItem:  WeatherView {
    
    func weatherDataAvailable() {
        
        self.weatherUpdate()
    }
}
