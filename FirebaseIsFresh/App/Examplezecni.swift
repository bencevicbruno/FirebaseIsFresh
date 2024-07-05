//
//  Examplezecni.swift
//  FirebaseIsFresh
//
//  Created by Bruno Benčević on 21.11.2023..
//

import SwiftUI

struct Examplezecni: View {
    
    @State private var clickCount = 0
    
    var body: some View {
        Text("Click count: \(clickCount)")
            .frame(width: 150, height: 50)
            .background(.blue)
            .foregroundColor(.white)
            .contentShape(Rectangle())
            .onTapGesture {
                clickCount += 1
            }
    }
}

#Preview {
    Examplezecni()
}
