//
//  UIContextualAction+ViewRepresentation.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 18/09/2023.
//

import UIKit

struct ContextualActionViewRepresentation {
    var style: UIContextualAction.Style
    var title: String?
    var imageName: String?
    var backgroundColor: UIColor?
}

extension UIContextualAction {
    convenience init(configuration: ContextualActionViewRepresentation, handler: @escaping UIContextualAction.Handler) {
        self.init(style: configuration.style, title: configuration.title, handler: handler)
        if let imageName = configuration.imageName {
            self.image = UIImage(systemName: imageName)
        }
        if let backgroundColor = configuration.backgroundColor {
            self.backgroundColor = backgroundColor
        }
    }
}
