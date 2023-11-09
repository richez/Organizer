//
//  WidgetCenter+Concurrency.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 10/11/2023.
//

import WidgetKit

extension WidgetCenter {
    func getCurrentConfigurations() async throws -> [WidgetInfo] {
        try await withCheckedThrowingContinuation { continuation in
            self.getCurrentConfigurations { continuation.resume(with: $0) }
        }
    }
}
