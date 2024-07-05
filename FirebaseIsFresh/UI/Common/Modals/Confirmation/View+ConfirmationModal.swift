//
//  View+ConfirmationModal.swift
//  FirebaseIsFresh
//
//  Created by Bruno Benčević on 19.11.2023..
//

import SwiftUI

extension View {
    
    func confirmationModal(_ binding: Binding<ConfirmationModalData?>) -> some View {
        self.overlay(alignment: .bottom) {
            ConfirmationModal(data: binding)
        }
    }
}
