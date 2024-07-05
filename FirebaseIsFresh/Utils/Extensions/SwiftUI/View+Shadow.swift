//
//  View+Shadow.swift
//  FirebaseIsFresh
//
//  Created by Bruno Benčević on 16.11.2023..
//

import SwiftUI

extension View {
    
    func addShadow(_ color: Color = .black.opacity(0.15), size: CGFloat = 8, blurRadius: CGFloat = 12, edges: Edge.Set = .all) -> some View {
        self.background(
            color
                .padding(edges, -size)
                .blur(radius: blurRadius))
    }
}
