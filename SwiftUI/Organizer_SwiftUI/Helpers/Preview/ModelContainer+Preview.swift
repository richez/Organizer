//
//  ModelContainer+Preview.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 13/10/2023.
//

import Foundation
import SwiftData

extension ModelContainer {
    static var preview: () throws -> ModelContainer = {
        let schema = Schema([Project.self, ProjectContent.self])
        let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: schema, configurations: [configuration])
        Task { @MainActor in
            PreviewDataGenerator.generateData(in: container.mainContext)
        }
        return container
    }
}
