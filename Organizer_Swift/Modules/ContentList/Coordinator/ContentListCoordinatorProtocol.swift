//
//  ContentListCoordinatorProtocol.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 01/10/2023.
//

import Foundation

protocol ContentListCoordinatorProtocol: AnyObject {
    /// Starts the ``ContentFormCoordinator`` with the specified ``ContentFormMode``
    func showContentForm(mode: ContentFormMode)

    /// Starts the ``URLCoordinator`` with the specified `URL` and ``ContentDisplayMode``
    func showContent(url: URL, mode: ContentDisplayMode)

    /// Presents an `UIAlertController` configurated with the specified `Error`.
    func show(error: Error)
}
