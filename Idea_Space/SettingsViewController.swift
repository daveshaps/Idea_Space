//
//  SettingsViewController.swift
//  Idea_Space
//
//  Created by Wish Carr on 11/16/16.
//  Copyright © 2016 David Shapiro. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class SettingsViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate
{

    //MARK: Properties
    
    @IBOutlet var neighborhoodMapView: MKMapView!
    @IBOutlet weak var neighborhoodTextField: UITextField!
    @IBOutlet weak var facebookProfileTextField: UITextField!
    @IBOutlet weak var facebookProfileLogoutButton: UIButton!
    
    let locationManager = CLLocationManager()
    
    
    
    //MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.locationManager.delegate = self
        let authorizationCode = CLLocationManager.authorizationStatus()
        
       //if authorization code not determined
        if authorizationCode == CLAuthorizationStatus.notDetermined && locationManager.responds(to: #selector(CLLocationManager.requestWhenInUseAuthorization))
        {
            if Bundle.main.object(forInfoDictionaryKey: "NSLocationWhenInUseDescription") != nil
            {
                locationManager.requestWhenInUseAuthorization()
            }
            else
            {
                print("No description provided")
            }
        }
        
        self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        self.locationManager.requestWhenInUseAuthorization()
        //could set this to always collecting location data instead. But here we do not.
        self.locationManager.startUpdatingLocation()
        self.neighborhoodMapView.showsUserLocation = true
    }

    //MARK: Location Delegate Methods
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let location = locations.last
        
        let center = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
        
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1))
        
        self.neighborhoodMapView.setRegion(region, animated: true)
        
        self.locationManager.stopUpdatingLocation()
        
        //Pin
        
        let locationPinCoord = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
        let annotation = MKPointAnnotation()
        annotation.coordinate = locationPinCoord
        
        neighborhoodMapView.addAnnotation(annotation)
        neighborhoodMapView.showAnnotations([annotation], animated: true)
        
        //geo coder
        
        let geoCoder = CLGeocoder()
      
        geoCoder.reverseGeocodeLocation(location!, completionHandler:
            { (placemarks, error) -> Void in
            
            var placeMark: CLPlacemark!
            placeMark = placemarks?[0]
            
            if let subLocality = placeMark.addressDictionary!["subLocality"] as? NSString
            {
                self.neighborhoodTextField.text = String(subLocality)

            }
            })
        
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("Errors: " + error.localizedDescription)
    }
    
    
    
    //MARK: Memory
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
