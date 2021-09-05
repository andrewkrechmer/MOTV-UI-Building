//
//  ModelElements.swift
//  MOTV-UI-Building
//
//  Created by Andrew Krechmer on 2021-08-31.
//

import SwiftUI

struct SecondaryInfo: Identifiable {
    var text: String
    var type: SecondaryInfoType
    var id = UUID().uuidString
}

enum SecondaryInfoType {
    
    case location
    case attendeeLimit
    case plusOnePolicy
    case activity
    
    func cellColor() -> Color {
        switch self {
        case .location:
            return Color.yellow
        default:
            return Color.white
        }
    }
}
