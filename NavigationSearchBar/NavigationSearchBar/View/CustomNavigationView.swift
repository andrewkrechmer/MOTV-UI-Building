//
//  CustomNavigationView.swift
//  NavigationSearchBar
//
//  Created by Andrew Krechmer on 2021-09-02.
//

import SwiftUI

struct CustomNavigationView: UIViewControllerRepresentable {
    
    
    func makeCoordinator() -> Coordinator {
        return CustomNavigationView.Coordinator(parent: self)
    }
    
    
    var view: AnyView
    
    // Ease of use
    
    var largeTitle: Bool
    var title: String
    var placeHolder: String
    
    // On search and on cancel closures
    
    var onSearch: (String) -> ()
    var onCancel: ()->()
    
    // Require closure on Call
    
    init(view: AnyView, placeHolder: String? = "Search", largeTitle: Bool? = true, title: String, onSearch: @escaping (String)->(), onCancel: @escaping ()->()) {
        self.view = view 
        
        self.placeHolder = placeHolder!
        self.largeTitle = largeTitle!
        self.title = title
        
        self.onSearch = onSearch
        self.onCancel = onCancel
    }
    
    // Integrating UIKir Navigation Controller With SwiftUI
    func makeUIViewController(context: Context) -> UINavigationController {
        
        // Requires SwiftUI View
        let childView = UIHostingController(rootView: view)
        
        let controller = UINavigationController(rootViewController: childView)
        
        // Nav Bar Data
        
        controller.navigationBar.topItem?.title = title
        controller.navigationBar.prefersLargeTitles = largeTitle
        
        // Search Bar
        
        let searchController = UISearchController()
        searchController.searchBar.placeholder = placeHolder
        
        searchController.searchBar.delegate = context.coordinator // Setting delegate
        
        searchController.obscuresBackgroundDuringPresentation = false // disabling dim bg
        controller.navigationBar.topItem?.hidesSearchBarWhenScrolling = false // disabling hide on scroll
        controller.navigationBar.topItem?.searchController = searchController  // Setting search bar in navbar
        
        return controller
        
    }
    
    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {
     
        // Updating real time
        uiViewController.navigationBar.topItem?.title = title
        uiViewController.navigationBar.topItem?.searchController?.searchBar.placeholder = placeHolder
        uiViewController.navigationBar.prefersLargeTitles = largeTitle
        
    }
    
    // Search bar delegate
    
    class Coordinator: NSObject, UISearchBarDelegate {
       
        var parent: CustomNavigationView
        
        init(parent: CustomNavigationView) {
            self.parent = parent
        }
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            self.parent.onSearch(searchText) // when text changes
        }
        
        func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            self.parent.onCancel() // when cancel button is clicked
        }
        
    }
    
}
