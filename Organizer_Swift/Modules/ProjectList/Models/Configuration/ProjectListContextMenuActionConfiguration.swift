//
//  ProjectListContextMenuActionConfiguration.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 19/09/2023.
//

import Foundation

enum ProjectListContextMenuAction {
    case duplicate
    case edit
    case delete
}

struct ProjectListContextMenuActionConfiguration {
    var title: String
    var imageName: String?
    var action: ProjectListContextMenuAction
}
