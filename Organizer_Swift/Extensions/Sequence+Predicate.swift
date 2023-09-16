//
//  Sequence+Predicate.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 16/09/2023.
//

import Foundation

extension Sequence {
    /// - Returns: Unfiltered array if predicate is `nil`, the filtered array otherwise
    func filter(_ predicate: Predicate<Self.Element>?) throws -> [Self.Element] {
        guard let predicate else { return Array(self) }
        return try self.filter(predicate)
    }
}
