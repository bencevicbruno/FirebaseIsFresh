//
//  PushNotificationsViewModel.swift
//  FirebaseIsFresh
//
//  Created by Bruno Benčević on 16.11.2023..
//

import UIKit

final class PushNotificationsViewModel: ObservableObject {
    
    @Published var isInEditMode = false
    @Published var notifications: [PushNotificationModel] = [
        .sample(small: false),
        .sample(small: true),
        .sample(small: false),
        .sample(small: true),
        .sample(small: false),
        .sample(small: true),
        .sample(small: false),
        .sample(small: true),
        .sample(small: false),
        .sample(small: true),
        .sample(small: false),
        .sample(small: true),
        .sample(small: false),
        .sample(small: true),
        .sample(small: false),
        .sample(small: true),
        .sample(small: false),
        .sample(small: true)
    ]
    
    @Published var selectedMap: [UUID: Bool] = [:]
    @Published var confirmationModalData: ConfirmationModalData?
    
    init() {
        
    }
    
    func deletePushNotification(_ notification: PushNotificationModel) {
        self.confirmationModalData = .init(
            title: "Delete Push Notification?",
            message: "Are you sure you want to delete \(notification.title)? This can not be undone.",
            confirmTitle: "Delete",
            isConfirmDestructive: true,
            confirmAction: { [weak self] in
                self?.notifications.removeAll(where: { $0.id == notification.id })
            })
    }
    
    func sendPushNotification(_ notification: PushNotificationModel) {
        print("Later homie")
    }
}

private extension PushNotificationsViewModel {
    
}
