//
//  NavbarTitleViewRepresentation.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 18/09/2023.
//

import UIKit

/// The view representation that will be applied to a ``NavbarTitleView``
struct NavbarTitleViewRepresentation {
    var numberOfLines: Int = 2
    var textAlignment: NSTextAlignment = .center
    var font: UIFont = .systemFont(ofSize: 17, weight: .semibold)
    var textColor: UIColor = .navbarTitle
}
