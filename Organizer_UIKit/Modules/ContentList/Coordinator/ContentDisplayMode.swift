//
//  ContentDisplayMode.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 01/10/2023.
//

import Foundation

/// Defines how the content should be displayed and is mapped
/// to ``URLCoordinatorMode`` at ``URLCoordinator`` initialization
/// (``URLCoordinatorMode/init(displayMode:url:)``)
enum ContentDisplayMode {
    case inApp
    case external
}

extension URLCoordinatorMode {
    init(displayMode: ContentDisplayMode, url: URL) {
        switch displayMode {
        case .inApp:
            self = .inApp(url)
        case .external:
            self = .external(url)
        }
    }
}
