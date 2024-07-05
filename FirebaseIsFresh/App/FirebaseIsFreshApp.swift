//
//  FirebaseIsFreshApp.swift
//  FirebaseIsFresh
//
//  Created by Bruno Benčević on 16.11.2023..
//

import SwiftUI
import FirebaseCore

@main
struct FirebaseIsFreshApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    init() {
        
    }
    
    var body: some Scene {
        WindowGroup {
            RootScreen()
                .preferredColorScheme(.light)
        }
    }
}
