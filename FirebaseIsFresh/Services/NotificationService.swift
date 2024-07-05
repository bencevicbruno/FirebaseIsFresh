//
//  NotificationService.swift
//  FirebaseIsFresh
//
//  Created by Bruno Benčević on 16.11.2023..
//

import Foundation
import UIKit
import UserNotifications
import FirebaseMessaging

final class NotificationService: NSObject {
    
    private let notificationCenter = UNUserNotificationCenter.current()
    private let application = UIApplication.shared
    private let firebaseMessaging = Messaging.messaging()
    
    override init() {
        super.init()
        
        notificationCenter.delegate = self
        firebaseMessaging.isAutoInitEnabled = true
        firebaseMessaging.delegate = self
    }
    
    func requestAuthorization() {
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        
        UNUserNotificationCenter.current().requestAuthorization(
          options: authOptions,
          completionHandler: { granted, error in }
        )
    }
    
    func registerForRemoteNotifications() {
        application.registerForRemoteNotifications()
    }
    
    func setAPNSToken(_ token: Data?) {
        firebaseMessaging.apnsToken = token
        
        
        if let token {
            print("Token: \(token.base64EncodedString())")
        }
        
//        print(firebaseMessaging.fcmToken)
        firebaseMessaging.token { token, error in
            if let token {
                print(token)
            }
            
            if let error {
                print(error)
            }
        }
    }
}

extension NotificationService: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        print(response.notification.request.content.userInfo.map { pair in "\(pair.key)=\(pair.value)" })
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification) async -> UNNotificationPresentationOptions {
        return [.banner, .sound, .badge]
    }
}

extension NotificationService: MessagingDelegate {
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
      print("Firebase registration token: \(String(describing: fcmToken))")

      let dataDict: [String: String] = ["token": fcmToken ?? ""]
      NotificationCenter.default.post(
        name: Notification.Name("FCMToken"),
        object: nil,
        userInfo: dataDict
      )
      // TODO: If necessary send token to application server.
      // Note: This callback is fired at each app startup and whenever a new token is generated.
    }
}
