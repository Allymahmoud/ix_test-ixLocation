//
//  ViewController.swift
//  iX_test
//
//  Created by Ally Mahmoud on 7/4/17.
//  Copyright © 2017 Ally Mahmoud. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, AddActivityDelegate {

    @IBOutlet weak var map: MKMapView!
    var delegate: AddActivityDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func defaultname() -> String? {
        return "Mahmoud"
    }
    
    func didAddActivity(activity: Activity){
//        self.activities.append(activity)
//        self.tableView?.reloadData()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "navToAddActivity" {
            let addActivityNavigationViewController = segue.destination as! UINavigationController
            let addActivityViewController = addActivityNavigationViewController.topViewController as! AddActivityViewController
            
            
            addActivityViewController.delegate = self
        }
        
    }
    
    


}

