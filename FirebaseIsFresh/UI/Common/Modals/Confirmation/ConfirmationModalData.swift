//
//  ConfirmationModalData.swift
//  FirebaseIsFresh
//
//  Created by Bruno Benčević on 19.11.2023..
//

import Foundation

struct ConfirmationModalData: Equatable, Identifiable {
    let id: UUID
    let title: String?
    let message: String
    let confirmTitle: String
    let isConfirmDestructive: Bool
    let confirmAction: EmptyCallback
    let cancelTitle: String
    let cancelAction: EmptyCallback?
    
    init(title: String? = nil,
         message: String,
         confirmTitle: String = "Confirm",
         isConfirmDestructive: Bool = false,
         confirmAction: @escaping EmptyCallback,
         cancelTitle: String = "Cancel",
         cancelAction: EmptyCallback? = nil) {
        self.id = UUID()
        self.title = title
        self.message = message
        self.confirmTitle = confirmTitle
        self.isConfirmDestructive = isConfirmDestructive
        self.confirmAction = confirmAction
        self.cancelTitle = cancelTitle
        self.cancelAction = cancelAction
    }
    
    static func == (lhs: ConfirmationModalData, rhs: ConfirmationModalData) -> Bool {
        return lhs.id == rhs.id
    }
    
    static func sample(title: String? = nil) -> ConfirmationModalData {
        return .init(title: title,
                     message: "Are you sure you want to confirm this action?",
                     confirmAction: { print("Confirm Tapped!") })
    }
}
