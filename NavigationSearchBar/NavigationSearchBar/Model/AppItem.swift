//
//  AppItem.swift
//  NavigationSearchBar
//
//  Created by Andrew Krechmer on 2021-09-02.
//

import SwiftUI

struct AppItem: Identifiable {
    var id = UUID().uuidString
    var name: String
    var source: String = "Apple"
}

var apps = [
    AppItem(name: "App Store"),
    AppItem(name: "Calculator"),
    AppItem(name: "Calendar"),
    AppItem(name: "Camera"),
    AppItem(name: "Clock"),
    AppItem(name: "Facetime"),
    AppItem(name: "Health"),
    AppItem(name: "Mail"),
    AppItem(name: "Maps"),
    AppItem(name: "Messages"),
    AppItem(name: "News"),
    AppItem(name: "Phone"),
    AppItem(name: "Photos"),
    AppItem(name: "Safari"),
    AppItem(name: "Settings"),
    AppItem(name: "Stocks"),
    AppItem(name: "Wallet"),
    AppItem(name: "Weather")
]
