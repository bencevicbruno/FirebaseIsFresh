//
//  GestureDisabledOnChangeModifier.swift
//  FirebaseIsFresh
//
//  Created by Bruno Benčević on 19.11.2023..
//

import SwiftUI

struct GestureDisabledOnChangeModifier<Value>: ViewModifier where Value: Equatable {
    
    let value: Value
    let time: TimeInterval
    
    @State private var gesturesEnabled = true
    
    init(value: Value, time: TimeInterval) {
        self.value = value
        self.time = time
    }
    
    func body(content: Content) -> some View {
        content
            .allowsHitTesting(gesturesEnabled)
            .onChange(of: value, initial: false) {
                gesturesEnabled = false
                
                DispatchQueue.main.asyncAfter(deadline: .now() + time) {
                    gesturesEnabled = true
                }
            }
    }
}
