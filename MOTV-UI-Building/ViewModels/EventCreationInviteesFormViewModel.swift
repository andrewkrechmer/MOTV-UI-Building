//
//  EventCreationInviteesFormViewModel.swift
//  MOTV-UI-Building
//
//  Created by Andrew Krechmer on 2021-09-17.
//

import SwiftUI
import Combine

class EventCreationInviteesFormViewModel: EventCreationFormViewModel {
    
    @Published var formIsValid: Bool = false
    
    @Published var friends: [UserViewModel] =  TestAssistant.directFriends
    
    private var cancellables = Set<AnyCancellable>()
    
    override init() {
        
        super.init()
        
        eventInviteesFormIsValid
            .receive(on: RunLoop.main)
            .assign(to: \.formIsValid, on: self)
            .store(in: &cancellables)
    }
    
    private var inviteesAreValid: AnyPublisher<Bool, Never> {
        $invitees
            .debounce(for: 0.8, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { $0.count >= 1 }
            .eraseToAnyPublisher()
    }
    
    private var minimumAttendeesIsValid: AnyPublisher<Bool, Never> {
        $minimumAttendees
            //.debounce(for: 0.8, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { $0 > 0 }
            .eraseToAnyPublisher()
    }
    
    private var maximumAttendeesIsValid: AnyPublisher<Bool, Never> {
        $maximumAttendees
            //.debounce(for: 0.8, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { $0 > 0 && $0 < 599 }
            .eraseToAnyPublisher()
    }
    
    
    private var eventInviteesFormIsValid: AnyPublisher<Bool, Never> {
        
        Publishers.CombineLatest3(inviteesAreValid, minimumAttendeesIsValid, maximumAttendeesIsValid)
            .map { $0 && $1 && $2 }
            .eraseToAnyPublisher()
        
    }
    
}

class UserViewModel: ObservableObject, Identifiable {
    var id: Int
    var firstName: String
    var lastName: String
    var profileImage: UIImage
    @Published var highlight: Bool
    
    init(id: Int, firstName: String, lastName: String, profileImage: UIImage, highlight: Bool) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.profileImage = profileImage
        self.highlight = highlight
    }
    
}




struct TestAssistant {
    
    static let directFriends: [UserViewModel] = [
        UserViewModel(id: 0, firstName: "Greg", lastName: "Sway", profileImage: UIImage(imageLiteralResourceName: "Man Profile #1"), highlight: false),
        UserViewModel(id: 1, firstName: "Dufas", lastName: "Dakota", profileImage: UIImage(imageLiteralResourceName: "Woman Profile #1"), highlight: false),
        UserViewModel(id: 2, firstName: "Bob", lastName: "Dwindle", profileImage: UIImage(imageLiteralResourceName: "Man Profile #2"), highlight: false),
        UserViewModel(id: 3, firstName: "Lorax", lastName: "Orlanda", profileImage: UIImage(imageLiteralResourceName: "Woman Profile #2"), highlight: false),
        UserViewModel(id: 4, firstName: "Holister", lastName: "Tamn", profileImage: UIImage(imageLiteralResourceName: "Man Profile #3"), highlight: false),
        UserViewModel(id: 5, firstName: "Alpham", lastName: "Popari", profileImage: UIImage(imageLiteralResourceName: "Woman Profile #3"), highlight: false),
        UserViewModel(id: 6, firstName: "Taki", lastName: "Atalono", profileImage: UIImage(imageLiteralResourceName: "Man Profile #4"), highlight: false),
        UserViewModel(id: 7, firstName: "Yuf", lastName: "Bruf", profileImage: UIImage(imageLiteralResourceName: "Woman Profile #4"), highlight: false),
        UserViewModel(id: 8, firstName: "Rori", lastName: "Bambardo", profileImage: UIImage(imageLiteralResourceName: "Man Profile #5"), highlight: false),
        UserViewModel(id: 9, firstName: "Gambles", lastName: "Quon", profileImage: UIImage(imageLiteralResourceName: "Woman Profile #5"), highlight: false),
    ]
    
}


