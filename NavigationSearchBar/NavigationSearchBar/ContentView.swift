//
//  ContentView.swift
//  NavigationSearchBar
//
//  Created by Andrew Krechmer on 2021-09-02.
//

import SwiftUI

struct ContentView: View {
    
    @State var filteredItems = apps
    
    
    var body: some View {

        CustomNavigationView(view: AnyView(Home(filterdItems: $filteredItems)), placeHolder: "Apps, Games", largeTitle: true, title: "Family Tings", onSearch: { text in
            
            // filter data
            if text != "" {
                self.filteredItems = apps.filter { $0.name.lowercased().contains(text.lowercased()) }
            }
            else {
                self.filteredItems = apps
            }
            
        }, onCancel: {
            self.filteredItems = apps
        })
        .ignoresSafeArea()
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
