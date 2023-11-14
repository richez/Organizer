//
//  Notification+Store.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 09/11/2023.
//

import Foundation

extension Notification.Name {
    static var didCreateProject: Notification.Name = .init("didCreateProject")
    static var didDeleteProject: Notification.Name = .init("didDeleteProject")
    static let willUpdateProject: Notification.Name = .init("willUpdateProject")
    static let didUpdateProjectContent: Notification.Name = .init("didUpdateProjectContent")
}
