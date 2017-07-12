//
//  AddActivityDelegate.swift
//  iX_test
//
//  Created by Ally Mahmoud on 7/5/17.
//  Copyright © 2017 Ally Mahmoud. All rights reserved.
//

import Foundation

protocol AddActivityDelegate {
    
    func didAddActivity(activity:ActivityDto)
    func defaultname() -> String?
    
    
    
    
}
