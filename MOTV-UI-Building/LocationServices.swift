//
//  LocationServices.swift
//  MOTV-UI-Building
//
//  Created by Andrew Krechmer on 2021-09-04.
//

import Foundation
import CoreLocation
import MapKit

final class LocationServices: NSObject, CLLocationManagerDelegate, ObservableObject {
    
    private let locationManager = CLLocationManager()
    
    var authorizationStatus: CLAuthorizationStatus = .restricted
    
    @Published var region: MKCoordinateRegion?
    var regionLatitudeBounds: Double?
    var regionLongitudeBounds: Double?
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
    
    
    // -- Permission changed
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        switch manager.authorizationStatus {
        
        case .denied:
            self.authorizationStatus = .denied
            
        case .notDetermined:
            self.authorizationStatus = .notDetermined
            manager.requestWhenInUseAuthorization()
            
        case .authorizedWhenInUse:
            self.authorizationStatus = .authorizedWhenInUse
            manager.requestLocation()
            
        case .authorizedAlways:
            self.authorizationStatus = .authorizedAlways
            manager.requestLocation()
        
        default:
            ()
        
        }
        
    }
    
    
    // -- Error
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        print("Location Manager Error: \(error.localizedDescription)")
        
    }
    
    
    // -- Getting the users region
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.last else { return }
        
        self.region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: self.regionLatitudeBounds ?? 10000, longitudinalMeters: self.regionLongitudeBounds ?? 10000)
        
    }
    
}
