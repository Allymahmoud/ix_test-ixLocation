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
import RealmSwift
import FirebaseStorage

class AddActivityViewController: UIViewController, CLLocationManagerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    @IBOutlet weak var imageDisplay: UIImageView!
    @IBOutlet weak var Activity_Text_Box: UITextField!
    @IBOutlet weak var Description_Text_Box: UITextField!
    @IBOutlet weak var progress: UIProgressView!
    
    @IBOutlet weak var selectImage: UIButton!
    
    //we need a way to tell the table view controller that we are done adding a new acivity
    //var activityTableViewController: ActivityTableViewController?

    var delegate: AddActivityDelegate?
    
    let locationManager: CLLocationManager = CLLocationManager()
    var latestLocation: CLLocation?
    
    
    var newActivity: ActivityDto?
    
    
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
        
        
        newActivity?.name = Activity_Text_Box.text
        newActivity?.description = Description_Text_Box.text
        
        if let image = newActivity?.image {
            // Get a reference to the storage service using the default Firebase App
            let storage = Storage.storage()
            
            // Create a storage reference from our storage service
            let storageRef = storage.reference()
            
            let imagesRef = storageRef.child("images/\(String(describing: newActivity?.name!)).jpg")
            
            // Local file you want to upload
            //let localFile = image. //URL(string: "path/to/image")!
            
            // Create the file metadata
            let metadata = StorageMetadata()
            metadata.contentType = "image/jpeg"
            
            // Upload file and metadata to the object 'images/mountains.jpg'
            //let uploadTask = storageRef.putFile(from: localFile, metadata: metadata)
            let jpg = UIImageJPEGRepresentation(image, CGFloat(1))
            let uploadTask = imagesRef.putData(jpg!)
            
            // Listen for state changes, errors, and completion of the upload.
            uploadTask.observe(.resume) { snapshot in
                // Upload resumed, also fires when the upload starts
            }
            
            uploadTask.observe(.pause) { snapshot in
                // Upload paused
            }
            
            uploadTask.observe(.progress) { snapshot in
                // Upload reported progress
                let percentComplete = 100.0 * Double(snapshot.progress!.completedUnitCount)
                    / Double(snapshot.progress!.totalUnitCount)
                self.progress.progress = Float(percentComplete)
            }
            
            uploadTask.observe(.success) { snapshot in
                // Upload completed successfully
                self.newActivity?.imageUrl = snapshot.metadata?.downloadURL()?.absoluteString
                self.postActivity()
            }
            
            uploadTask.observe(.failure) { snapshot in
                if let error = snapshot.error as NSError? {
                    switch (StorageErrorCode(rawValue: error.code)!) {
                    case .objectNotFound:
                        // File doesn't exist
                        break
                    case .unauthorized:
                        // User doesn't have permission to access file
                        break
                    case .cancelled:
                        // User canceled the upload
                        break
                        
                        /* ... */
                        
                    case .unknown:
                        // Unknown error occurred, inspect the server response
                        break
                    default:
                        // A separate error occurred. This is a good place to retry the upload.
                        break
                    }
                }
            }
        } else {
            postActivity()
        }
    }
    
    func postActivity() {
        Alamofire.request("https://ixlocation-8d268.firebaseio.com/activities.json", method: .post, parameters: newActivity?.toJSON(), encoding: JSONEncoding.default).responseJSON { response in
            
            switch response.result {
            case .success( _):
                
                self.delegate?.didAddActivity(activity: self.newActivity!)
                self.dismiss(animated: true, completion: nil)
            case .failure: break
                // Failure... handle error
            }
        }
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
