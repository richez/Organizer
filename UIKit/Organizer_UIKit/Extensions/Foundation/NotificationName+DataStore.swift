//
//  NotificationName+DataStore.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 08/09/2023.
//

import UIKit

extension Notification.Name {
    /// A notification that's posted when a new ``Project`` is created (``ProjectFormViewModel/createProject(with:)``)
    /// in order to update the project list (``ProjectListViewController/observeNotifications()``).
    static var didCreateProject: Notification.Name = .init("didCreateProject")

    /// A notification that's posted when an existing ``Project`` is updated
    /// ( ``ProjectFormViewModel/updateProject(_:values:)``) in order to update the project list
    ///  (``ProjectListViewController/observeNotifications()``).
    static var didUpdateProject: Notification.Name = .init("didCreateProject")

    /// A notification that's posted when a new ``ProjectContent`` is created
    /// (``ContentFormViewModel/createContent(with:)``) in order to update the content list
    /// (``ContentListViewController/observeNotifications()``).
    static var didCreateContent: Notification.Name = .init("didCreateContent")

    /// A notification that's posted when an existing ``ProjectContent`` is updated
    /// (``ContentFormViewModel/updateContent(_:values:)``) in order to update the content list
    /// (``ContentListViewController/observeNotifications()``).
    static var didUpdateContent: Notification.Name = .init("didUpdateContent")

    /// A notification that's posted when a ``ProjectContent`` is created or updated 
    /// (``ContentFormViewModel/createContent(with:)``, ``ContentFormViewModel/updateContent(_:values:)``)
    /// in order to update the project list (``ProjectListViewController/observeNotifications()``).
    static var didUpdateProjectContent: Notification.Name = .init("didUpdateProjectContent")
}
