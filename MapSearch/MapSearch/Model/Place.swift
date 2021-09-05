//
//  Place.swift
//  MapSearch
//
//  Created by Andrew Krechmer on 2021-09-02.
//

import SwiftUI
import MapKit

struct Place: Identifiable {
    
    var id = UUID().uuidString
    
    var placemark: CLPlacemark
    
}
