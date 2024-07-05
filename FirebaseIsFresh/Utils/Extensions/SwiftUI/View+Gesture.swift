//
//  View+Gesture.swift
//  FirebaseIsFresh
//
//  Created by Bruno Benčević on 19.11.2023..
//

import SwiftUI

extension View {
    
    func nativeBackDragGesture(_ action: @escaping EmptyCallback) -> some View {
        self.contentShape(Rectangle())
            .gesture(DragGesture(minimumDistance: 20, coordinateSpace: .global)
                .onEnded({ value in
                    guard value.startLocation.x < 40 else { return }
                    
                    if value.translation.width > 50 {
                        action()
                    }
                }))
    }
    
    func disableGestureOnChangeOf<Value>(value: Value, for time: TimeInterval) -> some View where Value: Equatable {
        self.modifier(GestureDisabledOnChangeModifier(value: value, time: time))
    }
}
