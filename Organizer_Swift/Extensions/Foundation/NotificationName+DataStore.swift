//
//  NotificationName+DataStore.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 08/09/2023.
//

import UIKit

extension Notification.Name {
    /// A notification that's posted when a new `Project` is created (cf. `ProjectFormViewModel`)
    /// in order to update the project list (cf. `ProjectListViewController`).
    static var didCreateProject: Notification.Name = .init("didCreateProject")

    /// A notification that's posted when an existing `Project` is updated (cf. `ProjectFormViewModel`)
    /// in order to update the project list (cf. `ProjectListViewController`).
    static var didUpdateProject: Notification.Name = .init("didCreateProject")

    /// A notification that's posted when a new `Content` is created (cf. `ContentFormViewModel`)
    /// in order to update the content list (cf. `ContentListViewController`).
    static var didCreateContent: Notification.Name = .init("didCreateContent")

    /// A notification that's posted when an existing `Content` is updated (cf. `ContentFormViewModel`)
    /// in order to update the content list (cf. `ContentListViewController`).
    static var didUpdateContent: Notification.Name = .init("didUpdateContent")

    /// A notification that's posted when a `Content` is created or updated (cf. `ContentFormViewModel`)
    /// in order to update the project list (cf. `ContentListViewController`).
    static var didUpdateProjectContent: Notification.Name = .init("didUpdateProjectContent")
}
