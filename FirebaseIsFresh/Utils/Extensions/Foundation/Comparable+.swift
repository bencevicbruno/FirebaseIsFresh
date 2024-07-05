//
//  Comparable+.swift
//  FirebaseIsFresh
//
//  Created by Bruno Benčević on 20.11.2023..
//

import Foundation

func clamp<T>(_ value: T, min minValue: T, max maxValue: T) -> T where T : Comparable {
    return min(max(value, minValue), maxValue)
}
