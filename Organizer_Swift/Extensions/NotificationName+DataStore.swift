//
//  NotificationName+DataStore.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 08/09/2023.
//

import Foundation

extension Notification.Name {
    static var didCreateProject: Notification.Name = .init("didCreateProject")
    static var didUpdateProject: Notification.Name = .init("didCreateProject")
    static var didCreateContent: Notification.Name = .init("didCreateContent")
    static var didUpdateProjectContent: Notification.Name = .init("didUpdateProjectContent")
}
