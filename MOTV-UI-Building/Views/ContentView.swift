//
//  ContentView.swift
//  MOTV-UI-Building
//
//  Created by Andrew Krechmer on 2021-08-20.
//

import SwiftUI


// MARK: - Events View

struct EventsView: View {
    var eventCells = [EventCell(), EventCell(), EventCell(), EventCell()]
    
    @State var presentEventCreationForm: Bool = false
    
    var body: some View {

        NavigationView {
            
            ZStack {
                
                ScrollView(.vertical, showsIndicators: false) { // Events Scroll View
                    
                    LazyVStack(alignment: .center, spacing: 22) {
                        
                        Spacer()
                        
                        ForEach(eventCells) { eventCell in
                            
                            eventCell
                            
                        }
                    }
                    
                }
                .navigationBarTitle("MOTV", displayMode: .inline)
                .background(Color.backGroundColor)
                .zIndex(0)
                
                CreateEventButton(presentEventCreationForm: $presentEventCreationForm) // + Button to create new event
                    .zIndex(2)
                
                BottomFadeIn() // Bottom Gradient
                    .ignoresSafeArea()
                    .zIndex(1)
                
            }
        }.sheet(isPresented: $presentEventCreationForm, content: {
            EventCreationForm(presentEventCreationForm: $presentEventCreationForm)
                .environmentObject(EventCreationDetialsViewModel())
        })

    }
}

struct BottomFadeIn: View {
    
    private let gradient = Gradient(stops : [Gradient.Stop(color: .backGroundColor, location: 0), Gradient.Stop(color: .backGroundColor, location: 0.5), Gradient.Stop(color: .backGroundColor.opacity(0), location: 1)])

    var body: some View {
        VStack {
            Spacer()
            LinearGradient(gradient: gradient, startPoint: .bottom, endPoint: .top)
                .frame(width: nil, height: 90, alignment: .bottom)
        }
    }
}

struct CreateEventButton: View {
    
    @Binding var presentEventCreationForm: Bool
    
    var body: some View {
       
        VStack {
         
            Spacer()
            
            Button(action: {
                presentEventCreationForm.toggle()
            }) {
                
                ZStack(alignment: .center) {
                    Text("+")
                        .offset(y: -5)
                        .font(.system(size: 70, weight: .light, design: .rounded))
                        .foregroundColor(.white)
                        .zIndex(1)
                    
                    RoundedRectangle(cornerRadius: 15)
                        .strokeBorder(Color.white, lineWidth: 2.5)
                        .background(RoundedRectangle(cornerRadius: 15).foregroundColor(Color.black))
                        .frame(width: 60, height: 55, alignment: .center)
                        .zIndex(0)
                }
            }
        }
    }
}


// MARK: - Event Cell

struct EventCell: View, Identifiable {
    
    var id = UUID.init()
    
    var body: some View {
        
        ZStack(alignment: .leading) {
            
            VStack(alignment: .leading, spacing: 30.0) {
                EventMainInfoView()
                    .padding(.top, 20.0)
                    .layoutPriority(1)
                Divider()
                EventAttendeesView()
                    .layoutPriority(2)
                
                EventActionButtonsView()
                    .padding(.bottom, 20.0)
                    .layoutPriority(0)
                    
            }
            .padding(.horizontal, 35.0)
            .background( // Background cell (Grey rounded rectangle)
                RoundedRectangle(cornerRadius: 15.0)
                    .scale(x: 0.95, y: 1.0, anchor: .center)
                    .foregroundColor(Color.foreGroundColor)
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .scale(x: 0.95, y: 1.0, anchor: .center)
                            .stroke(ThemeColors.gradient, style: StrokeStyle(lineWidth: 2, lineCap: .round))
                    )
                
                    
                    
                    //.shadow(color: .shadowColor, radius: 4.0, x: 0.0, y: 5.0)
            )

        }
    }
}

struct EventTopInfoView: View {
    
    var body: some View {
        
        HStack {
            
        }
        
    }
    
}

struct EventMainInfoView: View {
    
//    var eventViewModel: EventViewModel
    
    var body: some View {
        
        HStack(alignment: .top) {
            
            Image("Man Profile #1") // Event Host Image
                .resizable()
                .contentShape(Circle())
                .aspectRatio(contentMode: .fill)
                .frame(width: 70, height: 70, alignment: .center)
                .clipped()
                .padding(.trailing, 28.0)

            VStack(alignment: .leading, spacing: 7) {
                Text("Pool Party") // Event Title
                    .font(.system(size: 27, weight: .bold, design: .default))
                    .multilineTextAlignment(.leading)

                Text("September 23 | 5:20 pm") // Event Time
                    .font(.system(size: 20, weight: .medium, design: .default))
                    .multilineTextAlignment(.leading)
                
                Text("Andrew's House")
                    .font(.system(size: 18, weight: .regular, design: .default)).foregroundColor(.gray)
            }
        }
    }
}

struct EventAttendeesView: View {
    
//    var eventViewModel: EventViewModel
    struct Invitee: Hashable {
        var name: String
        var profileImage: String
        init(_ name: String, _ profile: String) {
            self.name = name
            self.profileImage = profile
        }
    }
    var invitees = [Invitee("Remi", "Man Profile #1-1"), Invitee("Viola", "Woman Profile #3"), Invitee("Zeya", "Woman Profile #1-1"), Invitee("Ferdinand", "Man Profile #3-1"), Invitee("Guy-Franco","Man Profile #6-1"), Invitee("Amatadore", "Man Profile #5-1"), Invitee("Kian", "Woman Profile #4-1"), Invitee("+7 more", "Woman Profile #9")]
    var int = [1,2]
    var body: some View {
        
        LazyVGrid(columns: [GridItem(), GridItem(), GridItem(), GridItem()], spacing: 20) {
            ForEach(invitees, id: \.self) { invitee in
                VStack {
                    Image(invitee.profileImage)
                        .attendeeImage()
                    Text(invitee.name)
                        .font(.system(size: 14, weight: .regular, design: .default))
                }
            }
        }
        
    }
}


struct EventActionButtonsView: View {
    
    var body: some View {
        
        HStack(alignment: .center, spacing: 20) {
            EventActionButtonView(buttonType: .moreInfo)
            EventActionButtonView(buttonType: .moreInfo)
            EventActionButtonView(buttonType: .moreInfo)
            EventActionButtonView(buttonType: .moreInfo)
        }
        
    }
    
}

struct EventActionButtonView: View {
    
    enum ButtonType {
        case moreInfo
        case accept
        case unsure
        case decline
        case groupChat
        case invitePlusOne
    }
    
    var buttonType: ButtonType
    
    var body: some View {
        ZStack {
            
            switch buttonType {
                case .moreInfo:
                    Text("+")
                    
                default:
                    Text("")
            }
            
            Circle()
                .foregroundColor(.clear)
                .background(ThemeColors.gradient).opacity(0.3)
                .background(Circle().stroke(ThemeColors.gradient, style: StrokeStyle(lineWidth: 2, lineCap: .round)))
                .clipShape(Circle())
            .frame(width: 55, height: 55, alignment: .center)
        }
            
        
    }
}


struct SecondaryInfoCell: View {
    var info: SecondaryInfo
    var body: some View {
        
        Text(info.text)
            .font(.system(size: 17, weight: .regular, design: .default))
            .padding(.all, 5.0)
            .background(ColoredRoundedRectanlge(color: info.type == .location ? MOTV_UI_BuildingApp.themeColor : Color.primary))
        
    }
}
    
struct ColoredRoundedRectanlge: View {
    @State var color: Color
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .foregroundColor(color).opacity(0.1)
            .background(RoundedRectangle(cornerRadius: 10).strokeBorder(lineWidth: 1).foregroundColor(color).opacity(0.5))
    }
}



// MARK: - SwiftUI Extensions

extension Image {
    
    func attendeeImage() -> some View {
        self
            .resizable()
            .contentShape(Circle())
            .aspectRatio(contentMode: .fill)
            .frame(width: 70, height: 70, alignment: .center)
            .clipped()
    }
}


// MARK: - Preview

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        // --- --- --- iPhone 11 --- --- ---
        EventsView()
        .preferredColorScheme(.dark)
        .previewDevice("iPhone 11")
        
        
//        // --- --- --- iPhone 12 mini --- --- ---
//        EventsView()
//        .preferredColorScheme(.dark)
//        .previewDevice("iPhone 12 mini")
//
//
//        // --- --- --- iPhone 8 --- --- ---
//        EventsView()
//        .preferredColorScheme(.dark)
//        .previewDevice("iPhone 8")
//
//
//        // --- --- --- iPhone SE --- --- ---
//        EventsView()
//        .preferredColorScheme(.dark)
//        .previewDevice("iPhone SE (2nd generation)")
//
//
//        // --- --- --- iPod Touch --- --- ---
//        EventsView()
//        .preferredColorScheme(.dark)
//        .previewDevice("iPod touch (7th generation)")
        
    }
    
}
