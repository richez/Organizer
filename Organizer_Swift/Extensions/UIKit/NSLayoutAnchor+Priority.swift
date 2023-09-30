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
    /// Improves the readability of constraint creation by avoiding to declare
    /// `NSLayoutConstraint` and setting up its `UILayoutPriority` later.
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
