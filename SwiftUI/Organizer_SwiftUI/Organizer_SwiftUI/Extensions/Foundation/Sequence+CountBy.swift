//
//  Sequence+CountBy.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 23/10/2023.
//

import Foundation

extension Sequence {
    func count<T: Hashable>(by value: KeyPath<Element, T>) -> [T: Int] {
        self.reduce(into: [:]) { result, element in
            result[element[keyPath: value], default: 0] += 1
        }
    }
}
