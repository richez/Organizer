//
//  ProjectContentListContextMenuActionConfiguration.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 19/09/2023.
//

import Foundation

enum ProjectContentListContextMenuAction {
    case openBrowser
    case copyLink
    case edit
    case delete
}

struct ProjectContentListContextMenuActionConfiguration {
    var title: String
    var imageName: String?
    var action: ProjectContentListContextMenuAction
}
