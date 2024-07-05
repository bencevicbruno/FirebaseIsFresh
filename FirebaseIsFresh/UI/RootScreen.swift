//
//  RootScreen.swift
//  FirebaseIsFresh
//
//  Created by Bruno Benčević on 16.11.2023..
//

import SwiftUI

struct RootScreen: View {
    
    @ObservedObject var viewModel = RootViewModel.instance
    
    var body: some View {
        NavigationStack(path: $viewModel.navigationPath) {
            DashboardScreen()
                .navigationDestination(for: RootNavigationDestination.self) { destination in
                    switch destination {
                    case .pushNotifications:
                        PushNotificationsScreen()
                    }
                }
        }
    }
}

#Preview {
    RootScreen()
}
