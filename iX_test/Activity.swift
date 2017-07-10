//
//  Activity.swift
//  iX_test
//
//  Created by Ally Mahmoud on 7/4/17.
//  Copyright © 2017 Ally Mahmoud. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import Gloss

class Activity{
    var name: String?
    var description: String?
    var latitude: Double?
    var longitude: Double?
    var image: UIImage?
    var imageUrl: String?
    var location: Location?
    
    //var image: UIImage
    //var location: GeoPoint
    
    required init?(json: JSON) {
        
        self.name = "Name" <~~ json
        self.description = "Description" <~~ json
        self.latitude = "Latitude" <~~ json
        self.longitude = "Longitude" <~~ json
        self.imageUrl = "ImageUrl" <~~ json
        self.location = "location" <~~ json
        
    }
    
    
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
    init(name: String?, description: String?, latitude: Double?, longitude: Double?, image: UIImage?){
        self.name = name
        self.description = description
        self.latitude = latitude
        self.longitude = longitude
        
        self.image = image
        //self.location = GeoPoint(latitude: 0.0, longitude: 0.0)
        
    }
    
    init(name: String?, description: String?, location: CLLocationCoordinate2D) {
        self.name = name
        self.description = description
        self.latitude = location.latitude
        self.longitude = location.longitude
    }
    
    
    init(dictionary: [String: AnyObject]) {
        self.name = dictionary["Name"] as? String
        self.description = dictionary["Description"] as? String
        self.latitude = dictionary["Latitude"] as? Double
        self.longitude = dictionary["Longitude"] as? Double
        self.imageUrl = dictionary["ImageUrl"] as? String
        self.image = UIImage(named: "panda.png")
        
        if let locationDictionary = dictionary["location"] as? [String: AnyObject] {
            self.location = Location(dictionary: locationDictionary)
        }
    }

    func getApplelocation() -> CLLocationCoordinate2D {
        var coordinate = CLLocationCoordinate2D()
        coordinate.latitude = self.latitude!
        coordinate.longitude = self.longitude!
        return coordinate
    }
    
    func toJSON() -> JSON? {
        return jsonify([
            "Name" ~~> self.name,
            "Description" ~~> self.description,
            "Latitude" ~~> self.latitude,
            "Longitude" ~~> self.longitude
            ])
    }
    
    
}
