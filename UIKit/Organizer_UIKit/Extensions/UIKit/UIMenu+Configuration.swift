//
//  UIMenu+Configuration.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 14/09/2023.
//

import UIKit

/// Defines the properties required to initialize an `UIMenu`
///
/// Allows the definition of a `UIMenu` structure in a file that is not meant
/// to use `UIKit` (i.e. `ViewModel`)
struct MenuConfiguration {
    var title: String = ""
    var imageName: String?
    var singleSelection: Bool = false
    var displayInline: Bool = false
    var items: [MenuItemConfiguration] = []
    var submenus: [MenuConfiguration] = []
}

extension UIMenu {
    convenience init(configuration: MenuConfiguration) {
        let image: UIImage? = {
            guard let imageName = configuration.imageName else { return nil }
            return UIImage(systemName: imageName)
        }()

        let options = {
            var options: UIMenu.Options = []
            if configuration.displayInline { options.insert(.displayInline) }
            if configuration.singleSelection { options.insert(.singleSelection) }
            return options
        }()

        let items = configuration.items.map(UIAction.init(configuration:))
        let submenus = configuration.submenus.map(UIMenu.init(configuration:))

        self.init(
            title: configuration.title,
            image: image,
            options: options,
            children: items + submenus
        )
    }
}
