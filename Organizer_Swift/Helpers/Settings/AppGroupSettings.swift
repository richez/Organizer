//
//  AppGroupSettings.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 26/09/2023.
//

import Foundation

/// Defines the settings (`UserDefaults`) that are shared between the app
/// and the share extension.
struct AppGroupSettings {
    @Storage(key: .shareExtensionDidAddContent, default: false)
    var shareExtensionDidAddContent: Bool

    init(appGroup: UserDefaults? = .appGroup) {
        let container: UserDefaults = appGroup ?? .standard
        self._shareExtensionDidAddContent.container = container
    }
}
