//
//  Location.swift
//  DuTu
//
//  Created by Jeroen Dunselman on 21/01/2019.
//  Copyright © 2019 Jeroen Dunselman. All rights reserved.
//

import Foundation
import MapKit
import CoreLocation

class DoTooLocation: NSObject, MKAnnotation {

    let coordinate: CLLocationCoordinate2D
    var locality: String?
    var label: UILabel?
    
    init(coordinate: CLLocationCoordinate2D, label: UILabel?) {
       
        self.coordinate = coordinate
        super.init()
        
        if let label = label {
            self.label = label
        }
        let _ = geocode(latitude: coordinate.latitude, longitude: coordinate.longitude)
//        {
////            locality = placemark.locality
////            label?.text = locality
//        }

        
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
                self.locality = placemark!.locality
                self.label?.text = self.locality
            }
        }
        
        return placemark
    }
}
