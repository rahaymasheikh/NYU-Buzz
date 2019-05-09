//  HomeViewController.swift
//  NYUBuzz_LocationProj
//
//  Created by nyuguest on 5/5/19.
//  Copyright © 2019 Team RSM. All rights reserved.
//
import UIKit
import CoreLocation

class HomeViewController: UIViewController, CLLocationManagerDelegate {
    
    //////////////////////////////
    // VARIABLES
    //////////////////////////////
    @IBOutlet weak var tokensLabel: UILabel!
    let locationManager = CLLocationManager();  // we use locationManager to retrieve location info
    let geoCoder = CLGeocoder(); // we use geoCoder to convert coordinates to an address
    let addressDist: Double = 1000;      // distance in meters for two CLLocations to be within each other to be considered the same address
    var user: User = User();
    
    //////////////////////////////
    // METHODS
    //////////////////////////////
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self;
        // ask to updateLocAuthoriz status
        locationManager.requestWhenInUseAuthorization();
    }
    
    
    @IBAction func tapCheckInButton(_ sender: Any) {
        userCheckIn()
    }
    
    // TODO: called when user presses "check-in"
    func userCheckIn(){
        locationManager.requestLocation()
    }
    
    // checks if user is at an event they subscribed for, if so, rewards user! (called after we get user location)
    func checkIfAtEvent(user: User, atLocation: CLLocation, onDate: Date) {
        var matchingEvent: Event?
        var matchingEventInd: Int?
        for (index, event) in user.events.enumerated() {
            if (atLocation.distance(from: event.location) <= addressDist) {
                if (event.startDate <= onDate && event.endDate <= event.endDate) {
                    matchingEvent = event
                    matchingEventInd = index
                    break;
                }
            }
        }
        // TODO: check if matchingEvent isn't null,  if so, play alert, update tokens, delete event
        if (matchingEvent != nil) {
            let alert = UIAlertController(title: "Checked in!", message: "You have successfuly checked in for the event \(matchingEvent!.name).", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                NSLog("The \"OK\" alert occured.")
            }))
            self.present(alert, animated: true, completion: nil)
            addTokens(forUser: user, tokens: matchingEvent!.tokens)
            deleteEvent(atIndex: matchingEventInd!, forUser: user)
        }
        else {
            let alert = UIAlertController(title: "No events", message: "You are not scheduled for any events at this time or location", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                NSLog("The \"OK\" alert occured.")
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    // updates value and display of tokens
    func addTokens(forUser: User, tokens: Int) {
        user.tokens += tokens;
        // update display of tokens
        tokensLabel.text = "\(user.tokens)"
    }
    
    // TODO: deletes user event and event in display
    func deleteEvent(atIndex: Int, forUser: User) {
        user.events.remove(at: atIndex)
        // TODO: update the table display
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //////////////////////////////
    // DELEGATE MTDS FOR LOCMANAGER
    //////////////////////////////
    
    // called if loc authoriz. status is changed, updates locAuthStatus
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("loc authZ status: \(status)")
    }
    
    // called once requestLocation is granted, displ. location to locationLabel
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let authZStatus = CLLocationManager.authorizationStatus();
        
        if (authZStatus == .authorizedAlways || authZStatus == .authorizedWhenInUse) {
            if let location = locations.first {
                // check if location, time matches with any user events
                checkIfAtEvent(user: user, atLocation: location, onDate: Date())
            }
        }
        else {
            print("ERROR: lacking correct locAuthZ status!")
        }
    }
    
    // catches any errors thrown by locationManager calls
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("ERROR: locationManager error \(error)")
    }
}

class User {
    init () {
        self.name = "Name"
        self.tokens = 0
        self.events = [Event(), Event(), Event()];
    }
    var name:String;
    var tokens:Int;
    var events:[Event];
}

class Event {
    init() {
        self.name = "EventName"
        self.location = CLLocation()
        self.tokens = 2
        
        // always have startDate be yesterday, endDate be tomorrow!
        let currentDate = Date()
        let yesterday: Date = Calendar.current.date(byAdding: .day, value: 1, to: currentDate)!
        let tomorrow: Date = Calendar.current.date(byAdding: .day, value: 1, to: currentDate)!
        self.startDate = yesterday
        self.endDate = tomorrow
    }
    var name: String;
    var location:CLLocation;
    var tokens:Int;
    var startDate:Date;
    var endDate:Date;
}
