//
//  OSLog+App.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 05/11/2023.
//

import Foundation
import OSLog

extension Logger {
    private static var subsystem: String { Bundle.main.bundleIdentifier ?? "Organizer" }

    static let swiftData = Logger(subsystem: subsystem, category: "SwiftData")
    static let deeplinks = Logger(subsystem: subsystem, category: "Deeplinks")
    static let viewUpdates = Logger(subsystem: subsystem, category: "viewupdates")
    static let forms = Logger(subsystem: subsystem, category: "forms")
}
