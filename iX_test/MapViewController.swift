//
//  ViewController.swift
//  iX_test
//
//  Created by Ally Mahmoud on 7/4/17.
//  Copyright © 2017 Ally Mahmoud. All rights reserved.
//

import UIKit
import MapKit
import Alamofire


class MapViewController: UIViewController, AddActivityDelegate, CLLocationManagerDelegate, MKMapViewDelegate{

    @IBOutlet weak var map: MKMapView!
    var delegate: AddActivityDelegate?
    var activites: [Activity] = []
    
    let locationManager = CLLocationManager()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.map.delegate = self
        
        
        
    }
    
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        print("it's working")
        // Don't want to show a custom image if the annotation is the user's location.
        guard !(annotation is MKUserLocation) else {
            print ("Annotation not registerd")
            return nil
            
        }
        
        // Better to make this class property
        let annotationIdentifier = "AnnotationIdentifier"
        
        var annotationView: MKAnnotationView?
        if let dequeuedAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier) {
            annotationView = dequeuedAnnotationView
            annotationView?.annotation = annotation
        }
        else {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
            annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        
        if let annotationView = annotationView {
            // Configure your annotation view here
            annotationView.canShowCallout = true
            for activity in self.activites{
                
                //check if the activity has an image
                if activity.image != nil{
                    
                    // Resize image
                    let pinImage = activity.image
                    let size = CGSize(width: 30, height: 30)
                    UIGraphicsBeginImageContext(size)
                    pinImage?.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
                    

                    
                    let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
                    UIGraphicsEndImageContext()
                    
                    annotationView.image = resizedImage
                    
                    
                }
                else{
                    annotationView.image = UIImage(named: "ic_location_on.png")
                }
            }
            
        }
        
        return annotationView
    }
    
    
    

    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func didAddActivity(activity: Activity){

//        self.activities.append(activity)
//        self.tableView?.reloadData()
        
        //self.addActivityMapPoint(activity: activity)
        if ((activity.latitude) != nil) {
    
            
            //change the center focus of the map to show the location of the new added activity
            let center = CLLocationCoordinate2D(latitude: activity.latitude!, longitude: activity.longitude!)
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 100, longitudeDelta: 100))
            self.map.setRegion(region, animated: true)
            
        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        Alamofire.request("https://ixlocation-8d268.firebaseio.com/activities.json").responseJSON(completionHandler: {
            response in
            //print(response.result.value)
            
            if let activityDictionary = response.result.value as? [String: AnyObject]{
                
                //remove all annotations from the map
                self.map.removeAnnotations(self.map.annotations)
                
                //clear the activities array
                self.activites = []
                
                
                
                for (key, value) in activityDictionary {
                    print ("Key: \(key)")
                    //print ("Value: \(value)")
                    
                    if let singleActivityDictionary = value as? [String: AnyObject]{
                        let activity = Activity(dictionary: singleActivityDictionary)
                        
                        //add all activities in our global list
                        self.activites.append(activity)
                        
                        //add all points to map
                        self.addActivityMapPoint(activity: activity)
                        //self.tableView.reloadData()
                    }
                    
                    
                }
                
                //configure test activity to display on the map
                /*let test_image = UIImage(named: "ic_my_location.png")
                
                
                
                let test_activity = Activity(name: "Ally Mahmoud", description: "This is home", latitude: -6.816330, longitude: 39.276638, image: test_image)
                self.activites.append(test_activity)
                self.addActivityMapPoint(activity: test_activity)
                print (self.activites[self.activites.count-1].description!)
                */
                
                
                
            }
            
        })
        //self.tableView.reloadData()
        
    }
    
    //function to add an activity to a map
    func addActivityMapPoint(activity: Activity){
        
        if ((activity.latitude) != nil) {
            let coordinate = CLLocationCoordinate2D(latitude: activity.latitude!, longitude: activity.longitude!)
            
            
            //instanitate a new point
            let point = MKPointAnnotation()
                        
            point.coordinate = coordinate
            point.title = activity.name
            point.subtitle = activity.description
            
            //add the point to the map
            map.addAnnotation(point)
            
            
            
        }

        
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

