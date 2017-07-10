//
//  ActivityTableViewController.swift
//  iX_test
//
//  Created by Ally Mahmoud on 7/4/17.
//  Copyright © 2017 Ally Mahmoud. All rights reserved.
//

import UIKit
import Alamofire

class ActivityTableViewController: UITableViewController, AddActivityDelegate {
    
    var activities: [Activity] = []
    
    func defaultname() -> String? {
        return "Ally"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        Alamofire.request("https://ixlocation-8d268.firebaseio.com/activities.json").responseJSON(completionHandler: {
            response in
            //print(response.result.value)
            
            if let activityDictionary = response.result.value as? [String: AnyObject]{
                
                self.activities = []
                
                for (key, value) in activityDictionary {
                    print ("Key: \(key)")
                    print ("Value: \(value)")
                    
                    if let singleActivityDictionary = value as? [String: AnyObject]{
                        let activity = Activity(dictionary: singleActivityDictionary)
                        self.activities.append(activity)
                        self.tableView.reloadData()
                    }
                    
                    
                }
            }
            
        })
        //self.tableView.reloadData()

    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return activities.count
    }

 
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "activityCell", for: indexPath) as! ActivityTableViewCell

        // Configure the cell...
        
//        cell.textLabel?.text = activities[indexPath.row].name
//        cell.detailTextLabel?.text = activities[indexPath.row].description
        
        cell.activityname.text = activities[indexPath.row].name
        cell.actvitydescription.text = activities[indexPath.row].description
        cell.activitylatitude.text  = "\(String(describing: activities[indexPath.row].latitude))"
        cell.activitylongitude.text = "\(String(describing: activities[indexPath.row].longitude))"
        

        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "navToAddActivity" {
            let addActivityNavigationViewController = segue.destination as! UINavigationController
            let addActivityViewController = addActivityNavigationViewController.topViewController as! AddActivityViewController
           
            
            addActivityViewController.delegate = self
        }
    
    }
    
    func addActivity (activity: Activity){
        self.activities.append(activity)
        self.tableView?.reloadData()
        
    }
    
    func didAddActivity(activity: Activity){
        self.activities.append(activity)
        self.tableView?.reloadData()
        
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
