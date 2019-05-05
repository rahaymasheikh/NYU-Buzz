//
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
    let locationManager = CLLocationManager();  // we use locationManager to retrieve location info
    let geoCoder = CLGeocoder(); // we use geoCoder to convert coordinates to an address
    let addressDist: Double = 1000;      // distance in meters for two CLLocations to be within each other to be considered the same address
    var user: User;
    
    //////////////////////////////
    // METHODS
    //////////////////////////////
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self;
        // ask to updateLocAuthoriz status
        locationManager.requestWhenInUseAuthorization();
    }
    
    // TODO: called when user presses "check-in"
    func userCheckIn(){
        locationManager.requestLocation()
    }
    
    // checks if user is at an event they subscribed for, if so, rewards user! (called after we get user location)
    func checkIfAtEvent(user: User, atLocation: CLLocation, onDate: Date) {
        var matchingEvent: Event
        for (index, event) in user.events.enumerated() {
            if (atLocation.distance(from: event.location) <= addressDist) {
                if (event.startDate <= onDate && event.endDate <= event.endDate) {
                    matchingEvent = event
                    break;
                }
            }
        }
        // TODO: check if matchingEvent isn't null,  if so, do all of that!
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
    var tokens:Int;
    var events:[Event];
}

class Event {
    var name: String;
    var location:CLLocation;
    var tokens:Int;
    var startDate:Date;
    var endDate:Date;
}
