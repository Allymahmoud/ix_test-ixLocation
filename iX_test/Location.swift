//
//  Location.swift
//  iX_test
//
//  Created by Ally Mahmoud on 7/7/17.
//  Copyright © 2017 Ally Mahmoud. All rights reserved.
//

import Foundation

class Location {
    
    var latitude: Double?
    var longitude: Double?
    
    init(dictionary: [String: AnyObject]) {
        self.latitude = dictionary["latitude"] as? Double
        self.longitude = dictionary["longitude"] as? Double
    }
    
}
