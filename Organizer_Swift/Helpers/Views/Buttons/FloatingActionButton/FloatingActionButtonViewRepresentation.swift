//
//  FloatingActionButtonViewRepresentation.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 06/09/2023.
//

import UIKit

/// The view representation that will be applied to a ``FloatingActionButton``
struct FloatingActionButtonViewRepresentation {
    var size: CGFloat
    var backgroundColor: UIColor
    var highlightedBackgroundColor: UIColor
    var selectedBackgroundColor: UIColor
    var disabledBackgroundColor: UIColor
    var tintColor: UIColor
    var image: UIImage?
}
