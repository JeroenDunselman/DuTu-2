//
//  Location.swift
//  DuTu
//
//  Created by Jeroen Dunselman on 21/01/2019.
//  Copyright © 2019 Jeroen Dunselman. All rights reserved.
//

import Foundation
import MapKit
class DoTooLocation: NSObject, MKAnnotation {
//    let title: String?
//    let locationName: String
//    let discipline: String
    let coordinate: CLLocationCoordinate2D
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
        
        super.init()
    }
    //    init(title: String, locationName: String, discipline: String, coordinate: CLLocationCoordinate2D) {
//        self.title = title
//        self.locationName = locationName
//        self.discipline = discipline
//        self.coordinate = coordinate
//
//        super.init()
//    }
}
