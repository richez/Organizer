//
//  ProjectContentListSwipeActionConfiguration.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 19/09/2023.
//

import Foundation

enum ProjectContentListSwipeAction {
    case delete
    case edit
}

struct ProjectContentListSwipeActionConfiguration {
    var title: String?
    var imageName: String?
    var action: ProjectContentListSwipeAction
}
