//
//  ActivityTableViewCell.swift
//  iX_test
//
//  Created by Ally Mahmoud on 7/6/17.
//  Copyright © 2017 Ally Mahmoud. All rights reserved.
//

import UIKit

class ActivityTableViewCell: UITableViewCell {


    @IBOutlet weak var activityname: UILabel!
    @IBOutlet weak var actvitydescription: UILabel!
    @IBOutlet weak var activitylatitude: UILabel!
    @IBOutlet weak var activitylongitude: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
