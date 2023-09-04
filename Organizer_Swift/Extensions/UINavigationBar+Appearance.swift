//
//  UINavigationBar+Appearance.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 05/09/2023.
//

import UIKit

extension UINavigationBar {
    func applyAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.navbarTitle]

        self.standardAppearance = appearance
        self.compactAppearance = appearance
        self.scrollEdgeAppearance = appearance
    }
}
