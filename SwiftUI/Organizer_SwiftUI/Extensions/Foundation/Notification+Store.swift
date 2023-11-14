//
//  Notification+Store.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 09/11/2023.
//

import Foundation

extension Notification.Name {
    /// A notification that's posted when a new ``Project`` is created (``StoreNotificationCenter/created(_:))``).
    ///
    /// The ``StoreNotificationCenter/UserInfoKey/projectID`` and ``StoreNotificationCenter/UserInfoKey/newValues``
    /// keys are provided in the user-info dictionary
    static var didCreateProject: Notification.Name = .init("didCreateProject")

    /// A notification that's posted when a ``Project`` is deleted (``StoreNotificationCenter/deleted(_:)``).
    ///
    /// The ``StoreNotificationCenter/UserInfoKey/projectID`` and ``StoreNotificationCenter/UserInfoKey/oldValues``
    /// keys are provided in the user-info dictionary
    static var didDeleteProject: Notification.Name = .init("didDeleteProject")

    /// A notification that's posted when a ``Project`` is updated (``StoreNotificationCenter/willUpdate(_:with:)``).
    ///
    /// The ``StoreNotificationCenter/UserInfoKey/projectID``, ``StoreNotificationCenter/UserInfoKey/oldValues`` and
    /// keys ``StoreNotificationCenter/UserInfoKey/newValues`` are provided in the user-info dictionary
    static let willUpdateProject: Notification.Name = .init("willUpdateProject")

    /// A notification that's posted when a ``ProjectContent`` is created, updated or deleted
    ///  (``StoreNotificationCenter/didUpdateContent(in:)``).
    ///
    /// The ``StoreNotificationCenter/UserInfoKey/projectID`` and ``StoreNotificationCenter/UserInfoKey/newValues``
    /// keys are provided in the user-info dictionary
    static let didUpdateProjectContent: Notification.Name = .init("didUpdateProjectContent")
}
