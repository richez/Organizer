//
//  ProjectListViewConfiguration.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 19/09/2023.
//

import Foundation

/// Define the properties used to configure the ``ProjectListView``
struct ProjectListViewConfiguration {
    var createButtonImageName: String
    var swipeActions: [ProjectListSwipeActionConfiguration]
    var contextMenuTitle: String
    var contextMenuActions: [ProjectListContextMenuActionConfiguration]
}
