//
//  Settings.swift
//  Weather
//
//  Created by Jeroen Dunselman on 22/12/2017.
//  Copyright © 2017 Jeroen Dunselman. All rights reserved.
//

import Foundation

struct Settings {
    //  url for weather forecast
     let openWeatherMapAPIKey = "f253a82b395b623b4473abb0ba4804c5"
     let urlForecast = "http://api.openweathermap.org/data/2.5/forecast/daily" //
     let urlCurrent = "http://api.openweathermap.org/data/2.5/weather"
    var location = "Rotterdam"
    var temperatureUnitFahrenheit = false
    var numberOfDays = 7

    public let units = (Celsius: "metric", Fahrenheit: "imperial")
    public var currentUnits = "metric"
}
