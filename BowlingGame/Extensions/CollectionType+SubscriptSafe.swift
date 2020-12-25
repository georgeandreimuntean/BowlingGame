//
//  CollectionType+SubscriptSafe.swift
//  BowlingGame
//
//  Created by George Muntean on 24/12/2020.
//

import Foundation

extension Collection {

    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Iterator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
