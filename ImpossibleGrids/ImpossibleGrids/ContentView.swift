//
//  ContentView.swift
//  ImpossibleGrids
//
//  Created by Andrew Krechmer on 2021-08-27.
//

import SwiftUI

struct ContentView: View {
                          
    var secondaryInfo = ["📍 Joana's House | 22 mins away", "MusicMusicMusicMusicMusicMusic", "25 Peopl Max ", "🌊  Outdoor Pool!", "🎵 Music", "🍾 BYOB"]
        
    var body: some View {

        VStack(alignment: .center) {
            
            SecondaryInfoCell(info: secondaryInfo[0])
                .frame(width: 310, height: 31, alignment: .center)
            SecondaryInfoCell(info: secondaryInfo[1])
                .frame(width: 310, height: 31, alignment: .center)
            SecondaryInfoCell(info: secondaryInfo[2])
                .frame(width: 120, height: 31, alignment: .leading)
            SecondaryInfoCell(info: secondaryInfo[3])
                .frame(width: 160, height: 31, alignment: .leading)
            SecondaryInfoCell(info: secondaryInfo[4])
                .frame(width: nil, height: 31, alignment: .leading)
            SecondaryInfoCell(info: secondaryInfo[5])
                .frame(width: nil, height: 31, alignment: .leading)
            
        }
        
    }
}


struct SecondaryInfoCell: View {
    
    var info: String
    
    var body: some View {
        Text(info)
            .padding(.all, 5.0)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .strokeBorder(Color.yellow, lineWidth: 1).opacity(0.6))
            .background(RoundedRectangle(cornerRadius: 10).foregroundColor(Color.yellow).opacity(0.1)
        )
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
            .previewDevice("iPhone 11")
    }
}
