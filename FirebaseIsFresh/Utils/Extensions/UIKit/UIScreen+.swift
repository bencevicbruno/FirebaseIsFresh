//
//  UIScreen+.swift
//  FirebaseIsFresh
//
//  Created by Bruno Benčević on 16.11.2023..
//

import UIKit

extension UIScreen {
    
    private static let window = UIApplication.shared.windows.first
    
    static let topSafePadding = window?.safeAreaInsets.top ?? 0
    static let bottomSafePadding = window?.safeAreaInsets.bottom ?? 0
    
    static let width = UIScreen.main.bounds.size.width
    static let height = UIScreen.main.bounds.size.height
}

