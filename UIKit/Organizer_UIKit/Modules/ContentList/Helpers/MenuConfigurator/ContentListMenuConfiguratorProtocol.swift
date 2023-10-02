//
//  ContentListMenuConfiguratorProtocol.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 02/10/2023.
//

import Foundation

protocol ContentListMenuConfiguratorProtocol {
    /// Returns a ``MenuConfiguration`` with the specified number of content, themes and values of
    /// ``ContentListSettings``.
    /// - Parameter handler: The action to be executed when a menu item is selected by the user.
    func configuration(numberOfContents: Int, themes: [String], handler: @escaping () -> Void) -> MenuConfiguration
}
