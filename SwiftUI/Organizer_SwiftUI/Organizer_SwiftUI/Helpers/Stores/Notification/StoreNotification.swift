//
//  StoreNotification.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 09/11/2023.
//

import Foundation

enum StoreNotification {
    case created(Project)
    case deleted(Project)
    case willUpdate(Project, ProjectValues)
    case didUpdateContent(Project)
}
