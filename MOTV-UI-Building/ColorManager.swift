//
//  ColorManager.swift
//  MOTV-UI-Building
//
//  Created by Andrew Krechmer on 2021-08-30.
//

import SwiftUI

extension Color {
    
    static let foreGroundColor = Color("ForegroundColor")
    
    static let backGroundColor = Color("BackgroundColor")
    
    static let accentGroundColor = Color("AccentGroundColor")
    
    static let shadowColor = Color("ShadowColor")
    
}

struct ThemeColors {
    
    static let colorSet: [Color] = [Color("Orange"), Color("Yellow"), Color("Red"), Color("Blue")]
    
    static let yellow: Color = Color("Yellow")
    
    static let orange: Color = Color("Orange")
    static let red: Color = Color("Red")
    static let blue: Color = Color("Blue")
    
    static let gradient = LinearGradient(colors: [orange, red, blue], startPoint: .topTrailing, endPoint: .bottomLeading)

}
