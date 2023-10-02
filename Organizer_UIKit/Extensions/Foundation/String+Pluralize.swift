//
//  String+Pluralize.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 16/09/2023.
//

import Foundation

extension String {
    /// Basic method that returns `nil` if `count` is `0` or less and
    /// adds an 's' at the end of the current `String` value if needed.
    ///
    /// This method will be replaced by string localization if needed.
    func pluralize(count: Int) -> String? {
        guard count > 0 else { return nil }
        return count >= 2 ? "\(count) \(self)s" : "\(count) \(self)"
    }
}
