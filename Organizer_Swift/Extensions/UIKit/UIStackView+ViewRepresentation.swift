//
//  UIStackView+ViewRepresentation.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 06/09/2023.
//

import UIKit

/// Defines the `UIStackView` main properties.
///
/// Improves the readability of the app `ViewRepresentation` by allowing to
/// declare one property per `UIStackView` (i.e. `formStackViewRepresentation`)
/// instead of a list of properties (i.e. `formStackViewAxis`, `formStackViewSpacing`, ...).
struct StackViewRepresentation {
    var axis: NSLayoutConstraint.Axis
    var distribution: UIStackView.Distribution
    var alignment: UIStackView.Alignment
    var spacing: CGFloat
    var layoutMargins: UIEdgeInsets?
}

extension UIStackView {
    func setup(with viewRepresentation: StackViewRepresentation) {
        self.axis = viewRepresentation.axis
        self.distribution = viewRepresentation.distribution
        self.alignment = viewRepresentation.alignment
        self.spacing = viewRepresentation.spacing

        if let layoutMargins = viewRepresentation.layoutMargins {
            self.layoutMargins = layoutMargins
            self.isLayoutMarginsRelativeArrangement = true
        }
    }
}
