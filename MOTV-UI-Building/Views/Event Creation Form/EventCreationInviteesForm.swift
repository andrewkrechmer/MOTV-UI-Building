//
//  EventCreationInviteesForm.swift
//  MOTV-UI-Building
//
//  Created by Andrew Krechmer on 2021-09-04.
//

import SwiftUI

struct EventCreationInviteesForm: View {
    
    @State private var activeTabIndex: Int = 0
    @State private var rects: [CGRect] = Array<CGRect>(repeating: CGRect(), count: 3)
    
    var body: some View {
        
        ZStack {
            
            RoundedRectangle(cornerRadius: 15).stroke(lineWidth: 3.0).foregroundColor(MOTV_UI_BuildingApp.themeColor)
                .frame(width: rects[activeTabIndex].size.width, height: rects[activeTabIndex].size.height)
//                .offset(x: rects[activeTabIndex].minX, y: rects[activeTabIndex].minY)
                .zIndex(1)
                .animation(.easeInOut(duration: 1.0))
                
            
            VStack {
                
                HStack(spacing: 45) {
                    InviteesFormTab(activeTab: $activeTabIndex, tabName: "Numbers", tabIndex: 0)
                    InviteesFormTab(activeTab: $activeTabIndex, tabName: "Groups", tabIndex: 1)
                    InviteesFormTab(activeTab: $activeTabIndex, tabName: "Friends", tabIndex: 2)
                }
                .padding(.horizontal, 35)
                .padding(.vertical, 12)
                .background(RoundedRectangle(cornerRadius: 8).fill(Color.foreGroundColor))
                .zIndex(0)
                
              //  Spacer()
                
            }
            .onAppear {
                
            }
            .onPreferenceChange(InviteesFormPreferenceKey.self) { preferences in
                for p in preferences {
                    self.rects[p.tabIndex] = p.rect
                }
            }
            
        }
        .coordinateSpace(name: "zStack")
        
    }
    
}

struct InviteesFormTab: View {
    
    @Binding var activeTab: Int
    
    let tabName: String
    let tabIndex: Int
    
    var body: some View {
        
        Text(tabName)
            .background(PreferenceViewSetter(index: tabIndex))
            .onTapGesture {
                self.activeTab = self.tabIndex
            }
    }
    
}


// MARK: - Preferences

struct InviteesFormTabData: Equatable {
    let tabIndex: Int
    let rect: CGRect
}

struct InviteesFormPreferenceKey: PreferenceKey {
    typealias Value = [InviteesFormTabData]
    
    static var defaultValue: [InviteesFormTabData] = []
    
    static func reduce(value: inout [InviteesFormTabData], nextValue: () -> [InviteesFormTabData]) {
        value.append(contentsOf: nextValue())
    }
}

struct PreferenceViewSetter: View {
    
    let index: Int
    
    var body: some View {
        GeometryReader { geometry in
            Rectangle()
                .fill(Color.clear)
                .preference(key: InviteesFormPreferenceKey.self,
                            value: [InviteesFormTabData(tabIndex: self.index, rect: geometry.frame(in: .named("zStack")))])
        }
    }
}


// MARK: - Preview

struct EventCreationInviteesForm_Previews: PreviewProvider {
    static var previews: some View {
        EventCreationInviteesForm()
    }
}
