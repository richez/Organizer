//
//  Logger+Widget.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 05/11/2023.
//

import Foundation
import OSLog

extension Logger {
    init(category: String) {
        let subsystem = Bundle.main.bundleIdentifier ?? "Widgets"
        self.init(subsystem: subsystem, category: category)
    }
}
