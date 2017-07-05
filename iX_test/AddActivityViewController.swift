//
//  AddActivityViewController.swift
//  iX_test
//
//  Created by Ally Mahmoud on 7/4/17.
//  Copyright © 2017 Ally Mahmoud. All rights reserved.
//

import UIKit

class AddActivityViewController: UIViewController {

    @IBOutlet weak var Activity_Text_Box: UITextField!
    @IBOutlet weak var Description_Text_Box: UITextField!
    
    //we need a way to tell the table view controller that we are done adding a new acivity
    var activityTableViewController: ActivityTableViewController?

    var delegate: AddActivityDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let defaultName = delegate?.defaultname()
        Activity_Text_Box.text = defaultName
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func save(_ sender: Any) {
        let activity = Activity(name: Activity_Text_Box.text!, description: Description_Text_Box.text!)
        
        
        
//        activityTableViewController?.activities.append(activity)
//        activityTableViewController?.tableView?.reloadData()
        
        delegate?.didAddActivity(activity: activity)
        self.dismiss(animated: true, completion: nil)
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
