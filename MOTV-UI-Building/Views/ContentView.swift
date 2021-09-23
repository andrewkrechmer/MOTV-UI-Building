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
    
    @State var presentEventCreationForm: Bool = true
    
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
            EventCreationForm()
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
                EventMainInfoView() // Host image, event title and time
                    .padding(.top, 20.0)
                    .layoutPriority(1)
                EventAttendeesView() // 3 images and 49 letter text displaying the most relevant attendees
                    .layoutPriority(2)
                EventSecondaryInfoView() // Secondary info (Location, activities, special policies, etc)
                    .padding(.bottom, 20.0)
                    .layoutPriority(0)
                    
            }
            .padding(.horizontal, 35.0)
            .background( // Background cell (Grey rounded rectangle)
                RoundedRectangle(cornerRadius: 15.0)
                    .scale(x: 0.95, y: 1.0, anchor: .center)
                    .foregroundColor(Color.foreGroundColor)
                    .shadow(color: .shadowColor, radius: 4.0, x: 0.0, y: 5.0)
            )

        }
    }
}

struct EventMainInfoView: View {
    
//    var eventViewModel: EventViewModel
    
    var body: some View {
        
        HStack {
            
            Image("Man Profile #1") // Event Host Image
                .resizable()
                .contentShape(Circle())
                .aspectRatio(contentMode: .fill)
                .frame(width: 50, height: 50, alignment: .center)
                .clipped()
                .padding(.trailing, 28.0)

            VStack(alignment: .leading, spacing: 7) {
                Text("Pool Party") // Event Title
                    .font(.system(size: 27, weight: .bold, design: .default))
                    .multilineTextAlignment(.leading)

                Text("Ongoing | 3:20") // Event Time
                    .font(.system(size: 22, weight: .medium, design: .default))
                    .multilineTextAlignment(.leading)
            }
        }
    }
}

struct EventAttendeesView: View {
    
//    var eventViewModel: EventViewModel
    
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            
            ZStack { // Images
                Image("Woman Profile #1")
                    .attendeeImage()
                    .zIndex(3.0)
                    .offset(x: 0, y: -15)
                Image("Man Profile #2")
                    .attendeeImage()
                    .zIndex(2.0)
                    .offset(x: 24)
                Image("Woman Profile #2")
                    .attendeeImage()
                    .zIndex(1.0)
                    .offset(x: 0, y: 15)
            }
            .padding(.trailing, 43.0)
            
            
            Text("Joanna, Chad, Michael, Kylie, Thor, Guy + 12 more") // Text
                .font(.system(size: 18, weight: .medium, design: .default))
                .multilineTextAlignment(.leading)
                .allowsTightening(true)
                .lineLimit(2)
                .lineSpacing(5.0)
                
        }
    }
}

struct EventSecondaryInfoView: View {
    
    //    var eventViewModel: EventViewModel
    
    @State var topSecondaryInfo: [SecondaryInfo] = [SecondaryInfo(text: "📍 Joana's House | 22 mins away", type: .location), SecondaryInfo(text: "25 Peopl Max ", type: .attendeeLimit), SecondaryInfo(text: "🌊  Outdoor Pool!", type: .activity)]
    @State var bottomSecondaryInfo: [SecondaryInfo] = [SecondaryInfo(text: "💉 Proof of Covid Vaccination Required", type: .activity), SecondaryInfo(text: "🎵 Music", type: .activity), SecondaryInfo(text: "🍾 BYOB", type: .activity)]
    
    var body: some View {
        
        ScrollView(.horizontal, showsIndicators: false) {
            
            VStack(alignment: .leading, spacing: nil)
            {
                HStack(alignment: .center, spacing: nil)
                {
                    ForEach(topSecondaryInfo) { info in
                        SecondaryInfoCell(info: info)
                    }
                }
                HStack(alignment: .center, spacing: nil) {
                    ForEach(bottomSecondaryInfo) { info in
                        SecondaryInfoCell(info: info)
                    }
                }
            }
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
            .frame(width: 34, height: 34, alignment: .center)
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
