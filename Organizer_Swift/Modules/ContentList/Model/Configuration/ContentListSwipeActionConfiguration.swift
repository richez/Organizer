//
//  ContentListSwipeActionConfiguration.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 19/09/2023.
//

import Foundation

enum ContentListSwipeAction {
    case delete
    case edit
}

struct ContentListSwipeActionConfiguration {
    var title: String?
    var imageName: String?
    var action: ContentListSwipeAction
}
