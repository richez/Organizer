//
//  UIAction+Configuration.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 14/09/2023.
//

import UIKit

struct MenuItemConfiguration {
    var title: String = ""
    var isOn: Bool = false
    var handler: (() -> Void)?
}

extension UIAction {
    convenience init(configuration: MenuItemConfiguration) {
        self.init(
            title: configuration.title,
            state: configuration.isOn ? .on : .off,
            handler: { _ in configuration.handler?() }
        )
    }
}
