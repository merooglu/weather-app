//
//  Location.swift
//  wheatherapp
//
//  Created by Mehmet Eroğlu on 14.10.2019.
//  Copyright © 2019 Mehmet Eroğlu. All rights reserved.
//

import CoreLocation

class Location {
    
    static var sharedInstance = Location()
    private init() {}
    
    var latitude: Double!
    var longitude: Double!
}
