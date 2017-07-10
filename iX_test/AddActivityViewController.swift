//
//  AddActivityViewController.swift
//  iX_test
//
//  Created by Ally Mahmoud on 7/4/17.
//  Copyright © 2017 Ally Mahmoud. All rights reserved.
//

import UIKit
import MapKit
import Alamofire

class AddActivityViewController: UIViewController, CLLocationManagerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    @IBOutlet weak var imageDisplay: UIImageView!
    @IBOutlet weak var Activity_Text_Box: UITextField!
    @IBOutlet weak var Description_Text_Box: UITextField!
    
    @IBOutlet weak var selectImage: UIButton!
    
    //we need a way to tell the table view controller that we are done adding a new acivity
    //var activityTableViewController: ActivityTableViewController?

    var delegate: AddActivityDelegate?
    
    let locationManager: CLLocationManager = CLLocationManager()
    var latestLocation: CLLocation?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let defaultName = delegate?.defaultname()
        Activity_Text_Box.text = defaultName
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
        //start updating location if location manager is enabled
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
        
        
        
        
        
        
        
        
    }
    
    
    
    
    @IBAction func selectImage(_ sender: Any) {
        //Image picker
        
        let imagePickerController: UIImagePickerController = UIImagePickerController()
        
        imagePickerController.delegate = self
        
        
        imagePickerController.sourceType = .photoLibrary
        self.present(imagePickerController, animated: true, completion: nil)
        
        
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        self.imageDisplay.isHidden = false
        self.imageDisplay.image = selectedImage
        
        self.selectImage.isHidden = true
        
        
        self.dismiss(animated: true, completion: nil)
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func save(_ sender: Any) {
        
        var activity: Activity?
        
        
        if let location = self.latestLocation {
            activity = Activity(name: Activity_Text_Box.text!, description: Description_Text_Box.text!,latitude: location.coordinate.latitude , longitude: location.coordinate.longitude)
            
        }
        else{
          activity = Activity(name: Activity_Text_Box.text!, description: Description_Text_Box.text!)
        }
        
        
        
        
//        activityTableViewController?.activities.append(activity)
//        activityTableViewController?.tableView?.reloadData()
        
        //Alamofire.request("https://ixlocation-8d268.firebaseio.com/activities.json", method: .post, parameters: activity?.toJSON(), enc
        
    
        
        Alamofire.request("https://ixlocation-8d268.firebaseio.com/activities.json", method: .post, parameters: activity?.toJSON(), encoding: JSONEncoding.default).responseJSON(completionHandler: {
            response in
            //print(response.result.value)
            
            switch response.result{
            case .success:
                self.delegate?.didAddActivity(activity: activity!)
                self.dismiss(animated: true, completion: nil)
                break
            case .failure:
                //TODO: Display an error dialog
                break
            }

            
        })
        
/*        Alamofire.request("https://ixlocation.firebaseio.com/activities.json", method: .post, parameters: activity?.toJSON(), encoding: JSONEncoding.default).responseJSON(completionHandler: {
            response in
            
            switch response.result{
            case .success:
                self.delegate?.didAddActivity(activity: activity!)
                self.dismiss(animated: true, completion: nil)
                break
            case .failure:
                //TODO: Display an error dialog
                break
            }
        })
*/
        
        
        /*
        delegate?.didAddActivity(activity: activity!)
        self.dismiss(animated: true, completion: nil)
        */
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.latestLocation = locations[0]
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
