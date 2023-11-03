//
//  ProjectWindowViewModel.swift
//  MacOrganizer
//
//  Created by Thibaut Richez on 01/11/2023.
//

import Foundation
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
            return self.store.project(with: identifier, in: context)
        }
    }
}
