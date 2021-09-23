//
//  EventCreationInviteesForm2.swift
//  MOTV-UI-Building
//
//  Created by Andrew Krechmer on 2021-09-13.
//

import SwiftUI

struct EventCreationInviteesForm2: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var viewModel: EventCreationInviteesFormViewModel = EventCreationInviteesFormViewModel()
    
    @State var chosenTab: Int = 3
    @State var backButtonActive: Bool = true
    
    var body: some View {
        
        NavigationView {
            
            GeometryReader { geometry in
                
                VStack {
                    
                    HStack {
                        Button(action: {
                            self.presentationMode.wrappedValue.dismiss()
                        }, label: {
                            EventCreationFormNavigationButtonView(active: $backButtonActive, text: "Details")
                        })
                        Spacer()
                        NavigationLink(destination: EventCreationSecondaryDetailsForm(), label: {
                            EventCreationFormNavigationButtonView(active: $viewModel.formIsValid, text: "Activites")
                        }).disabled(!viewModel.formIsValid)
                    }
                    .padding(.top,0)
                    .padding(.bottom, 12)
                    
                    Picker("Tab", selection: $chosenTab) {
                        Text("Numbers").tag(1)
                        Text("Groups").tag(2)
                        Text("Friends").tag(3)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                    ZStack {
                        
                        NumbersView()
                            .environmentObject(viewModel)
                            .animation(.easeInOut(duration: 0.4))
                            .offset(x: geometry.size.width * CGFloat(1-chosenTab))
                        
                        GroupsView()
                            .environmentObject(viewModel)
                            .animation(.easeInOut(duration: 0.4))
                            .offset(x: geometry.size.width * CGFloat(2-chosenTab))
                        
                        FriendsView()
                            .environmentObject(viewModel)
                            .animation(.easeInOut(duration: 0.4))
                            .offset(x: geometry.size.width * CGFloat(3-chosenTab))
                        
                    }
                    
                    Spacer()
                    
                }
                .navigationBarHidden(true)
                .padding(.horizontal, 20)
                .padding(.vertical, 20)
                
                
            }
            
        }
        .navigationBarHidden(true)
        
    }
    
}


// MARK: - Numbers

private struct NumbersView: View {
    
    @EnvironmentObject var viewModel: EventCreationInviteesFormViewModel
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            VStack(alignment: .leading, spacing: 30) {
                
                HStack(alignment: .center, spacing: 20) {
                    Text("Min Attendees")
                    Picker("Min Attendees", selection: $viewModel.minimumAttendees) {
                        ForEach(0..<200, id: \.self) { num in
                            Text("\(num)")
                        }
                    }
                    .frame(width: 70, height: 40, alignment: .center)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                }
                
                HStack(alignment: .center, spacing: 20) {
                    Text("Max Attendees")
                    Picker("Max Attendees", selection: $viewModel.maximumAttendees) {
                        ForEach(2..<200, id: \.self) { num in
                            Text("\(num)")
                        }
                    }
                    .frame(width: 70, height: 40, alignment: .center)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                }
                
            }
            .padding(.bottom, 23)
            
            Text("If the amount of friends who plan to attend doesn’t reach the minimum the Motv will be cancelled. Motv will stop inviting friends when the max is reached.")
            
            Spacer()
            
        }
        
    }
    
}


// MARK: - Groups

private struct GroupsView: View {
    
    @EnvironmentObject var viewModel: EventCreationInviteesFormViewModel
    
    var body: some View {
        
        Text("Groups")
        
    }
    
}


// MARK: - Friends

private struct FriendsView: View {
     
    @EnvironmentObject var viewModel: EventCreationInviteesFormViewModel
    
    @State var search: String = ""
    
    var body: some View {
        
        VStack {
            
            TextField("Searchs Friends", text: $search)
            
            List() {
                
                ForEach(viewModel.friends, id: \.id) { friend in
                    
                    HStack {
                        
                        Image(uiImage: friend.profileImage)
                            .resizable()
                            .contentShape(Circle())
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 50, height: 50, alignment: .center)
                            .clipped()
                            .padding(.trailing, 28.0)
                        
                        Text("\(friend.firstName) \(friend.lastName)")
                            .font(.system(size: 20, weight: .medium, design: .default))
                            .foregroundColor(friend.highlight ? .green : .primary)
                        
                        Spacer()
                        
                        Image(systemName: friend.highlight ? "checkmark.circle.fill" : "circlebadge")
                            .font(.title)
                            .foregroundColor(friend.highlight ? .green : .gray)
                     
                    }
                    .onTapGesture(perform: {
                        friend.highlight.toggle()
                        self.viewModel.objectWillChange.send()
                        viewModel.invitees.append(friend.id)
                    })
                    
                }
                
            }
            .listStyle(InsetGroupedListStyle())
        }
        
    }
    
}



// MARK: - Previews

struct EventCreationInviteesForm2_Previews: PreviewProvider {
    static var previews: some View {
        EventCreationInviteesForm2()
        
    }
}
