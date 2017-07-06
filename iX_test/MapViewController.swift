//
//  ViewController.swift
//  iX_test
//
//  Created by Ally Mahmoud on 7/4/17.
//  Copyright © 2017 Ally Mahmoud. All rights reserved.
//

import UIKit
import MapKit


class MapViewController: UIViewController, AddActivityDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var map: MKMapView!
    var delegate: AddActivityDelegate?
    
    
    let locationManager = CLLocationManager()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        // Ask for Authorisation from the User.
//        self.locationManager.requestAlwaysAuthorization()
//        
//        // For use in foreground
//        self.locationManager.requestWhenInUseAuthorization()
//        
//        if CLLocationManager.locationServicesEnabled() {
//            locationManager.delegate = self
//            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
//            locationManager.startUpdatingLocation()
//        }

        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func didAddActivity(activity: Activity){

//        self.activities.append(activity)
//        self.tableView?.reloadData()
        
        let coordinate = CLLocationCoordinate2D(latitude: activity.latitude!, longitude: activity.longitude!)
        
        
        //instanitate a new point
        let point = MKPointAnnotation()
        point.coordinate = coordinate
        point.title = activity.name
        
        //add the point to the map
        map.addAnnotation(point)
        
        
        //change the center focus of the map to show the location of the new added activity
        let center = CLLocationCoordinate2D(latitude: activity.latitude!, longitude: activity.longitude!)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10))
        self.map.setRegion(region, animated: true)
        
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "navToAddActivity" {
            let addActivityNavigationViewController = segue.destination as! UINavigationController
            let addActivityViewController = addActivityNavigationViewController.topViewController as! AddActivityViewController
            
            
            addActivityViewController.delegate = self
        }
        
    }
    
    func defaultname() -> String? {
        return "Mahmoud"
    }
    
    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
//        print("locations = \(locValue.latitude) \(locValue.longitude)")
//    }
//    
    


}

