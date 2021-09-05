//
//  MapViewModel.swift
//  MapSearch
//
//  Created by Andrew Krechmer on 2021-09-02.
//

import Foundation
import MapKit
import CoreLocation

class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @Published var mapView = MKMapView()
    
    @Published var region: MKCoordinateRegion!
    
    // Alert
    @Published var permissionDenied = false
    
    // Map Type
    @Published var mapType: MKMapType = .standard
    
    // SearchText
    @Published var searchText = ""
    
    // Searched Places
    @Published var places : [Place] = []
    
    // Updating Map Type
    
    func updateMapType() {
        
        if mapType == .standard {
            mapType = .hybrid
            mapView.mapType = mapType
        }
        else {
            mapType = .standard
            mapView.mapType = mapType
        }
        
    }
    
    // Focus Location
    
    func focusLocation() {
        
        guard let _ = region else { return }
        
        mapView.setRegion(region, animated: true)
        
        mapView.setVisibleMapRect(mapView.visibleMapRect, animated: true)
        
    }
    
    // Search Places
    
    func searchQuery() {
        
        places.removeAll()
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchText
        
        // Fetch
        MKLocalSearch(request: request).start { response, _region in
            
            guard let result = response else { return }
            
            self.places = result.mapItems.compactMap({ item -> Place? in
                return Place(placemark: item.placemark)
            })
        }
        
    }
    
    // Pick Search Result
    
    func selectPlace(place: Place) {
        
        // Showing Pin On Map
        
        searchText = ""
        
        guard let coordinate = place.placemark.location?.coordinate else { return }
        
        let pointAnnotation = MKPointAnnotation()
        pointAnnotation.coordinate = coordinate
        pointAnnotation.title = place.placemark.name ?? "No Name"
        
        mapView.removeAnnotations(mapView.annotations) // Removing All Old Ones
        
        mapView.addAnnotation(pointAnnotation)
        
        // Moving Map to the annotation location
        
        let coordinateRegion = MKCoordinateRegion(center: coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
        
        mapView.setRegion(coordinateRegion, animated: true)
        mapView.setVisibleMapRect(mapView.visibleMapRect, animated: true)
        
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        // Checking Permission
        
        switch manager.authorizationStatus {
        case .denied:
            permissionDenied.toggle()
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        case .authorizedWhenInUse:
            manager.requestLocation()
        default:
            ()
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        print(error.localizedDescription)
        
    }
    
    // Getting user Region
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.last else { return }
        
        self.region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
        
        // Updating Map
        self.mapView.setRegion(self.region, animated: true)
        
        // Smooth Animations
        self.mapView.setVisibleMapRect(self.mapView.visibleMapRect, animated: true)
        
    }
    
}
