//
//  Activity.swift
//  iX_test
//
//  Created by Ally Mahmoud on 7/4/17.
//  Copyright © 2017 Ally Mahmoud. All rights reserved.
//

import Foundation
import UIKit

class Activity{
    var name: String?
    var description: String?
    var latitude: Double?
    var longitude: Double?
    
    //var image: UIImage
    //var location: GeoPoint
    
    
    init(name: String?, description: String?){
        self.name = name
        self.description = description
        
        //self.image = nil
        //self.location = GeoPoint(latitude: 0.0, longitude: 0.0)
        
    }
    
    init(name: String?, description: String?, latitude: Double?, longitude: Double?){
        self.name = name
        self.description = description
        self.latitude = latitude
        self.longitude = longitude
        
        //self.image = nil
        //self.location = GeoPoint(latitude: 0.0, longitude: 0.0)
        
    }

}
