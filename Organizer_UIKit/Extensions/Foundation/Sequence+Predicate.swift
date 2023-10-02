//
//  Sequence+Predicate.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 16/09/2023.
//

import Foundation

extension Sequence {
    /// Returns an unfiltered array if the predicate is `nil`. The filtered array otherwise
    func filter(_ predicate: Predicate<Self.Element>?) throws -> [Self.Element] {
        guard let predicate else { return Array(self) }
        return try self.filter(predicate)
    }
}
