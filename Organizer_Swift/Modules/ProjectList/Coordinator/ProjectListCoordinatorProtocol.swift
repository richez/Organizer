//
//  ProjectListCoordinatorProtocol.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 01/10/2023.
//

import Foundation

protocol ProjectListCoordinatorProtocol: AnyObject {
    /// Starts the ``ProjectFormCoordinator`` with the specified ``ProjectFormMode``
    func showProjectForm(mode: ProjectFormMode)

    /// Starts the ``ContentListCoordinator`` with the specified ``Project``
    func showContentList(of project: Project)

    /// Pops all the view controllers on the stack except the root optionally animating the UI changes.
    func popToRoot(animated: Bool)

    /// Presents an `UIAlertController` configurated with the specified `Error`.
    func show(error: Error)
}
