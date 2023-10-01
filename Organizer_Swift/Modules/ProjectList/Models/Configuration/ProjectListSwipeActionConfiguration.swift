//
//  ProjectListSwipeActionConfiguration.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 19/09/2023.
//

import Foundation

enum ProjectListSwipeAction {
    case delete
    case edit
}

struct ProjectListSwipeActionConfiguration {
    var title: String?
    var imageName: String?
    var action: ProjectListSwipeAction
}
