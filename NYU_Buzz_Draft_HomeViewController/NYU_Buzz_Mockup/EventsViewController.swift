//
//  EventsViewController.swift
//  NYU_Buzz_Mockup
//
//  Created by Rahayma Sheikh on 5/3/19.
//  Copyright © 2019 nyu.edu. All rights reserved.
//

import UIKit
import CoreLocation

class EventsViewController: UIViewController {
    
    /////////////////////
    // VARIABLES
    /////////////////////
    
    
    @IBOutlet weak var eventsTableView: UITableView!
    /*
    let cellReuseId = "cell"
    var allEvents: [Event] = [Event(), Event(), Event()]

    override func viewDidLoad() {
        super.viewDidLoad()
        eventsTableView.dataSource = self
        eventsTableView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    // determine # of sections in table view
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // determine # of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allEvents.count
    }
    
    // populate the TableView
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // TODO: create and use custom table view cell called Event_TableViewCell
        let cell: Home_TableViewCell = self.eventsTableView.dequeueReusableCell(withIdentifier: cellReuseId) as! Home_TableViewCell
        cell.eventName.text = self.allEvents[indexPath.row].name
        cell.eventTime.text = "\(self.allEvents[indexPath.row].tokens)"
        cell.eventTime.text = "\(self.allEvents[indexPath.row].startDate)"
        cell.eventLocation.text = "\(self.allEvents[indexPath.row].location)"
        return cell
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    */

}
