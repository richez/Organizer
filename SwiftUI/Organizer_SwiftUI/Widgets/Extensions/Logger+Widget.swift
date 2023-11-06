//
//  Logger+Widget.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 05/11/2023.
//

import Foundation
import OSLog

extension Logger {
    private static var subsystem: String { Bundle.main.bundleIdentifier ?? "Organizer" }

    static let swiftData = Logger(subsystem: subsystem, category: "SwiftData")
    static let timelineProviders = Logger(subsystem: subsystem, category: "TimelineProvider")
    static let entityQueries = Logger(subsystem: subsystem, category: "EntityQuery")
}
