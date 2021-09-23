//
//  MOTV_UI_BuildingApp.swift
//  MOTV-UI-Building
//
//  Created by Andrew Krechmer on 2021-08-20.
//

import SwiftUI
import UIKit


@main
struct MOTV_UI_BuildingApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    static let themeColor: Color =  /*ThemeColors.colorSet.randomElement() ??*/ ThemeColors.yellow
    
    var body: some Scene {
        WindowGroup {
            EventsView()
        }
    }
}

class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        // -- Navigation Bar Appearance
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.shadowColor = .none
        navigationBarAppearance.titleTextAttributes = [.foregroundColor: UIColor(.primary), .font: UIFont(name: "GTAmericaTrial-ExtBdIt", size: 36) ?? UIFont.systemFont(ofSize: 36, weight: .bold)]
        UINavigationBar.appearance().standardAppearance = navigationBarAppearance
        
        return true
    }
    
}
