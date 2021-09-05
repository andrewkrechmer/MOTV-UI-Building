//
//  Home.swift
//  MapSearch
//
//  Created by Andrew Krechmer on 2021-09-02.
//

import SwiftUI
import CoreLocation

struct Home: View {
    @StateObject var mapData = MapViewModel()
    
    // Locatio Manager
    @State var locationManager = CLLocationManager()
    
    var body: some View {
        
        ZStack {
            
            MapView()
                .environmentObject(mapData)
                .ignoresSafeArea(.all, edges: .all)
         
            VStack {
                
                VStack(spacing: 0) {
                    
                    HStack {
                        
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        
                        TextField("Search", text: $mapData.searchText)
                            .colorScheme(.light)
                        
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal)
                    .background(Color.white)
                    
                    // Displaying Results
                    
                    if !mapData.places.isEmpty && mapData.searchText != "" {
                        
                        ScrollView {
                            
                            VStack(spacing: 15) {
                                
                                ForEach(mapData.places) { place in
                                    
                                    Text(place.placemark.name ?? "")
                                        .foregroundColor(.black)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding(.leading)
                                        .onTapGesture {
                                            
                                            mapData.selectPlace(place: place)
                                            
                                        }
                                    
                                    Divider()
                                    
                                }
                                
                            }
                            .padding(.top)
                            
                        }
                        .background(Color.white)
                        
                    }
                    
                }
                .padding()
                
                Spacer()
                
                VStack {
                    
                    Button(action: mapData.focusLocation, label: {
                        
                        Image(systemName: "location.fill")
                            .font(.title2)
                            .padding(10)
                            .background(Color.primary)
                            .clipShape(Circle())
                        
                    })
                    
                    Button(action: mapData.updateMapType, label: {
                        
                        Image(systemName: mapData.mapType == .standard ? "network" : "map")
                            .font(.title2)
                            .padding(10)
                            .background(Color.primary)
                            .clipShape(Circle())
                        
                    })
                    
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding()
            }
            
        }
        .onAppear(perform: {
            
            locationManager.delegate = mapData
            locationManager.requestWhenInUseAuthorization()
            
        })
        // Permission denied alert
        .alert(isPresented: $mapData.permissionDenied) {
            Alert(title: Text("Permission Denied"), message: Text("Please Enable Permission In App Settings"), dismissButton: .default(Text("Go to Settings"), action: {
                
                //Redirect to user settings
                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                
            }))
        }
        .onChange(of: mapData.searchText, perform: { value in
            
            // Searching Places
            let delay = 0.3
            
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                
                if value == mapData.searchText {
                    
                    // Search
                    self.mapData.searchQuery()
                    
                }
                
            }
            
        })
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
            .previewDevice("iPhone 11")
    }
}
