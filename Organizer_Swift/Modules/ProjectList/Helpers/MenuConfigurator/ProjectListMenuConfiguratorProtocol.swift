//
//  ProjectListMenuConfiguratorProtocol.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 01/10/2023.
//

import Foundation

protocol ProjectListMenuConfiguratorProtocol {
    /// Returns a ``MenuConfiguration`` with the specified number of project, themes and values of
    /// ``ProjectListSettings``.
    /// - Parameter handler: The action to be executed when a menu item is selected by the user.
    func configuration(numberOfProjects: Int, themes: [String], handler: @escaping () -> Void) -> MenuConfiguration
}
