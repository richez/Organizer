//
//  AppGroupSettings.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 26/09/2023.
//

import Foundation

struct AppGroupSettings {
    @Storage(key: .shareExtensionDidAddContent, default: false)
    var shareExtensionDidAddContent: Bool

    init(suiteName: String = "group.thibautrichez.organizer.container") {
        let container: UserDefaults = .init(suiteName: suiteName) ?? .standard
        self._shareExtensionDidAddContent.container = container
    }
}
