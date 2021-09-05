//
//  FontManager.swift
//  MOTV-UI-Building
//
//  Created by Andrew Krechmer on 2021-08-31.
//

import SwiftUI

struct FontManager {
    
    var requestedFont: Font
    
    enum TypeFace: String {
        case GTAmericaExtendedBoldItalic = "GTAmericaTrial-ExtBdIt"
    }
    
    init(typeFace: TypeFace, size: CGFloat) {
        
        requestedFont = Font.custom(typeFace.rawValue, size: size)
        
    }
    
}
