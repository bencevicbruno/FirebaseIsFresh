//
//  RootViewModel.swift
//  FirebaseIsFresh
//
//  Created by Bruno Benčević on 16.11.2023..
//

import SwiftUI

enum RootNavigationDestination {
    case pushNotifications
}

final class RootViewModel: ObservableObject {
    
    static let instance = RootViewModel()
    
    @Published var navigationPath = NavigationPath()
    
    private init() {
        
    }
    
    func goBack() {
        navigationPath.removeLast()
        
    }
    
    func goTo(_ destination: RootNavigationDestination) {
        navigationPath.append(destination)
    }
}
