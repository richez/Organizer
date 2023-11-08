//
//  ProjectWindowViewModel.swift
//  MacOrganizer
//
//  Created by Thibaut Richez on 01/11/2023.
//

import Foundation
import OSLog
import SwiftData

extension ProjectWindow {
    struct ViewModel {
        // MARK: - Properties

        private let store: ProjectStoreReader

        // MARK: - Initialization

        init(store: ProjectStoreReader = ProjectStore()) {
            self.store = store
        }

        // MARK: - Public

        func project(with identifier: PersistentIdentifier?, in context: ModelContext) -> Project? {
            guard let identifier else { return nil }

            let project = self.store.project(with: identifier, in: context)

            Logger.viewUpdates.info("""
          Showing window for project \(project?.title ?? "") (\(project?.identifier.uuidString ?? ""))
          """)

            return project
        }
    }
}
