//
//  UIContextualAction+ViewRepresentation.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 18/09/2023.
//

import UIKit

extension UIContextualAction {
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
