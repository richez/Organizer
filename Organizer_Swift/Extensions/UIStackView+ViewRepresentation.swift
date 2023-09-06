//
//  UIStackView+ViewRepresentation.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 06/09/2023.
//

import UIKit

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
