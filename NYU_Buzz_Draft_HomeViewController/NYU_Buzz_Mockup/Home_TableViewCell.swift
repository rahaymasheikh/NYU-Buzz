//
//  Home_TableViewCell.swift
//  NYU_Buzz_Mockup
//
//  Created by Rahayma Sheikh on 5/3/19.
//  Copyright © 2019 nyu.edu. All rights reserved.
//

import UIKit

class Home_TableViewCell: UITableViewCell {

    // label outlet for event name
    @IBOutlet weak var eventName: UILabel!
    
    // label outlet for the amount of points an event is worth
    @IBOutlet weak var eventRewardVal: UILabel!
    
    // label outlet for time of event
    @IBOutlet weak var eventTime: UILabel!
    
    // label outlet for location of event
    @IBOutlet weak var eventLocation: UILabel!
    
    // action outlet for checkin button
    @IBAction func checkinButton(_ sender: UIButton) {
    }
    
}
