//
//  PushNotificationsScreen.swift
//  FirebaseIsFresh
//
//  Created by Bruno Benčević on 16.11.2023..
//

import SwiftUI

struct PushNotificationsScreen: View {
    
    @StateObject var viewModel = PushNotificationsViewModel()
    let rootViewModel = RootViewModel.instance
    
    @State private var selectionHapticTrigger = true
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            notificationsList
                .padding(.top, NavigationBar.size(includeSafeArea: true))
            
            NavigationBar("Push Notifications",
                          leadingItem: .back { rootViewModel.goBack() },
                          trailingItem: trailingNavigationItem)
            .disableGestureOnChangeOf(value: viewModel.isInEditMode, for: 0.2)
        }
        .fullscreenFrame(alignment: .topLeading)
        .nativeBackDragGesture {
            rootViewModel.goBack()
        }
        .confirmationModal($viewModel.confirmationModalData)
        .toolbar(.hidden, for: .navigationBar)
        .animation(.linear(duration: 0.2), value: viewModel.isInEditMode)
        .animation(.linear(duration: 0.25), value: viewModel.notifications)
        .onChange(of: viewModel.isInEditMode, initial: false) {
            if viewModel.isInEditMode {
                self.selectionHapticTrigger.toggle()
            }
        }
    }
}

private extension PushNotificationsScreen {
    
    var trailingNavigationItem: NavigationBarItem {
        viewModel.isInEditMode ? .text("Done") {
            viewModel.isInEditMode = false
        } : .text("Edit") {
            viewModel.isInEditMode = true
        }
    }
    
    var notificationsList: some View {
        ScrollView(.vertical) {
            LazyVStack(alignment: .leading, spacing: 0) {
                ForEach(viewModel.notifications) { notification in
                    PushNotificationCell(
                        model: notification,
                        isInEditMode: $viewModel.isInEditMode,
                        isSelected: selectionBinding(for: notification),
                        onSwipedToSend: {
                            viewModel.sendPushNotification(notification)
                        },
                        onSwipedToDelete: {
                            viewModel.deletePushNotification(notification)
                        })
                    
                    if notification != viewModel.notifications.last {
                        Divider()
                    }
                }
            }
            .padding(.top, 12)
        }
    }
    
    func selectionBinding(for notification: PushNotificationModel) -> Binding<Bool> {
        return .init(get: {
            return viewModel.selectedMap[notification.id] ?? false
        }, set: { value in
            viewModel.selectedMap[notification.id] = value
        })
    }
}

#Preview {
    PushNotificationsScreen()
}
