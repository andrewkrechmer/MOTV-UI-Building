//
//  EventCreationFormViewModel.swift
//  MOTV-UI-Building
//
//  Created by Andrew Krechmer on 2021-09-23.
//

import Foundation

class EventCreationFormViewModel: ObservableObject {
    
    @Published var eventName: String = ""
    @Published var startDate: Date = Date()
    @Published var endDate: Date = Date()
    @Published var location: SavedLocation = SavedLocation(commonName: "", addressString: "", latitude: 0, longitude: 0)
    
    @Published var invitees: [Int] = []
    @Published var minimumAttendees: Int = 0
    @Published var maximumAttendees: Int = 35
    @Published var allowPlusOnes: Bool = false
    
    @Published var activities: [SecondaryInfo] = []
    
    func postEvent() {
        
        
        //eventRepository.addEvent(newEvent)
        
    }
    
}
