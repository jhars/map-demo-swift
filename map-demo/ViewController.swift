//
//  ViewController.swift
//  map-demo
//
//  Created by Jon Harlan on 11/18/15.
//  Copyright © 2015 Jon Harlan. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


class ViewController: UIViewController, CLLocationManagerDelegate {
//    MARK: - Outlets
    @IBOutlet weak var myMapView: MKMapView!
//  MARK: Local Vaiables
    var locationManager = CLLocationManager()
// MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        locationManager.requestWhenInUseAuthorization()
    }
    // MARK: - Button interactions
    @IBAction func findMeBtn(sender: AnyObject) {
        locationManager.requestLocation()
        print("find me button")
        if let location = locationManager.location {
            addPin(location)
        }
        
    }

    // MARK:  - CLLocationMangerDelegte Methods
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        
        print("did this shit work?")
        let lastLocation = locations[locations.count-1]
        centerMapOnLocation(lastLocation)
    }

    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
    
    }
    
    // MARK: - Map Interaction Methods
    let regionRadius: CLLocationDistance = 1000
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        self.myMapView.setRegion(coordinateRegion, animated: true)
    }
    
    
    
    func addPin(location:CLLocation) {
        //create annotation
        let annotation = MKPointAnnotation()
        //set its properties: coords, name
        annotation.title = "you are here"
        annotation.coordinate = location.coordinate
        myMapView.addAnnotation(annotation)
    }
}
