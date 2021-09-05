//
//  Home.swift
//  NavigationSearchBar
//
//  Created by Andrew Krechmer on 2021-09-02.
//

import SwiftUI

struct Home: View {
    
    @Binding var filterdItems: [AppItem]
    
    var body: some View {
        
        // List View
        
        ScrollView(.vertical, showsIndicators: false, content: {
            
            VStack(spacing: 15) {
                
                ForEach(filterdItems) { item in
                    
                    CardView(item: item)
                    
                }
                
            }
            .padding()
            
        })
        
    }
}

