//
//  ContentListContextMenuActionConfiguration.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 19/09/2023.
//

import Foundation

enum ContentListContextMenuAction {
    case openBrowser
    case copyLink
    case edit
    case delete
}

struct ContentListContextMenuActionConfiguration {
    var title: String
    var imageName: String?
    var action: ContentListContextMenuAction
}
