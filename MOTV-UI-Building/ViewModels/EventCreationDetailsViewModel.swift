//
//  EventCreationDetailsViewModel.swift
//  MOTV-UI-Building
//
//  Created by Andrew Krechmer on 2021-09-07.
//

import SwiftUI
import Combine

class EventCreationDetialsViewModel: EventCreationFormViewModel {
    
    @Published var formIsValid: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    
    override init() {
        
        super.init()
        
        eventDetailsAreValidPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.formIsValid, on: self)
            .store(in: &cancellables)
    }
    
    private var eventNameIsValid: AnyPublisher<Bool, Never> {
        $eventName
            .debounce(for: 0.8, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { $0.count > 1 }
            .eraseToAnyPublisher()
    }
    
    private var startDateIsValid: AnyPublisher<Bool, Never> {
        $startDate
            .debounce(for: 0.8, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { $0 >= Date() - 1 }
            .eraseToAnyPublisher()
    }
    
    private var endDateIsValid: AnyPublisher<Bool, Never> {
        $endDate
            .debounce(for: 0.8, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { $0 > self.startDate + 1}
            .eraseToAnyPublisher()
    }
    
    private var locationIsValid: AnyPublisher<Bool, Never> {
        $location
            .removeDuplicates()
            .map { $0 != SavedLocation(commonName: "", addressString: "", latitude: 0, longitude: 0) }
            .eraseToAnyPublisher()
    }
    
    private var eventDetailsAreValidPublisher: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest4(eventNameIsValid, startDateIsValid, endDateIsValid, locationIsValid)
            .map { $0 && $1 && $2 && $3 }
            .eraseToAnyPublisher()
    }
    
}
