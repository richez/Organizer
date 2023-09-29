//
//  NSLayoutAnchor+Priority.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 06/09/2023.
//

import UIKit

extension NSLayoutAnchor {
    /// Returns a `NSLayoutConstraint` as defined by `constraint(equalTo:constant:)`
    /// plus an `UILayoutPriority`.
    ///
    /// Allows the caller to specify the added parameter directly instead
    /// of declarating the `NSLayoutConstraint` and setting up its priority
    /// later.
    @objc
    func constraint(
        equalTo anchor: NSLayoutAnchor<AnchorType>,
        constant c: CGFloat,
        priority: UILayoutPriority
    ) -> NSLayoutConstraint {
        let constraint = self.constraint(equalTo: anchor, constant: c)
        constraint.priority = priority
        return constraint
    }
}
