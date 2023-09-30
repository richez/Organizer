//
//  UIContextualAction+ViewRepresentation.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 18/09/2023.
//

import UIKit

extension UIContextualAction {
    /// Initialize a `UIContextualAction` as defined by `init(style:title:handler:)`
    /// plus an `backgroundColor` and `imageName`
    ///
    /// Improves the readability of a contextual action creation by avoiding to declare
    /// `UIContextualAction` and setting up its `backgroundColor` and `imageName` later.
    convenience init(style: UIContextualAction.Style,
                     title: String?,
                     backgroundColor: UIColor?,
                     imageName: String?,
                     handler: @escaping UIContextualAction.Handler) {
        self.init(style: style, title: title, handler: handler)
        self.backgroundColor = backgroundColor
        if let imageName {
            self.image = UIImage(systemName: imageName)
        }
    }
}
