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
    /// Allows the caller to specify the added parameters directly instead
    /// of initializing the `UIContextualAction` and setting up its priority
    /// later.
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
