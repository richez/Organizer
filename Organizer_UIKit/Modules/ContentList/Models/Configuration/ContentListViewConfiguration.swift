//
//  ContentListViewConfiguration.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 19/09/2023.
//

import Foundation

/// Define the properties used to configure the ``ContentListView``
struct ContentListViewConfiguration {
    var createButtonImageName: String
    var swipeActions: [ContentListSwipeActionConfiguration]
    var contextMenuTitle: String
    var contextMenuActions: [ContentListContextMenuActionConfiguration]
}
