//
//  LoginViewController.swift
//  iX_test
//
//  Created by Ally Mahmoud on 7/11/17.
//  Copyright © 2017 Ally Mahmoud. All rights reserved.
//

import UIKit
import FacebookCore
import FacebookLogin

class LoginViewController: UIViewController, LoginButtonDelegate {

    @IBOutlet weak var bottomview: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        if let accessToken = AccessToken.current {
        //            // User is logged in, use 'accessToken' here.
        //            self.performSegue(withIdentifier: "navToMain", sender: nil)
        //        }
        
        // Do any additional setup after loading the view.
        let loginButton = LoginButton(readPermissions: [ .publicProfile ])
        //loginButton.center = bottomview.center
        loginButton.delegate = self
        
        bottomview.addSubview(loginButton)
        
    }
    
    
    func loginButtonDidCompleteLogin(_ loginButton: LoginButton, result: LoginResult) {
        // Navigate to the main view controller
        self.performSegue(withIdentifier: "navToMain", sender: nil)
        
    }
    
    func loginButtonDidLogOut(_ loginButton: LoginButton) {
        
    }
    
    /*
     func loginButtonDidCompleteLogin(_ loginButton: LoginButton, result: LoginResult) {
     // Navigate to the main view controller
     self.performSegue(withIdentifier: "navToMain", sender: nil)
     }
     
     func loginButtonDidLogOut(_ loginButton: LoginButton) {
     
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
