//
//  EventCreationActivitiesFormViewModel.swift
//  MOTV-UI-Building
//
//  Created by Andrew Krechmer on 2021-09-23.
//

import Foundation

class EventCreationActivitiesFormViewModel: ObservableObject {
    
    @Published var activities: [SecondaryInfo] = []
    
    @Published var formIsValid: Bool = false
    
}
