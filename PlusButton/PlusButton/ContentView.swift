//
//  ContentView.swift
//  PlusButton
//
//  Created by Andrew Krechmer on 2021-08-31.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        ZStack(alignment: .center) {
            Text("+")
                .offset(y: -4.7)
                .font(.system(size: 70, weight: .medium, design: .rounded))
                .foregroundColor(.white)
                .zIndex(1)
            
            RoundedRectangle(cornerRadius: 10)
                .strokeBorder(Color.white, lineWidth: 2.5)
                .background(RoundedRectangle(cornerRadius: 10).foregroundColor(Color.black))
                .frame(width: 50, height: 50, alignment: .center)
                .zIndex(0)
            
        }
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
