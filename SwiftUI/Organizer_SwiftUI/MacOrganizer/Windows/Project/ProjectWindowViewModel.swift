//
//  ProjectWindowViewModel.swift
//  MacOrganizer
//
//  Created by Thibaut Richez on 20/10/2023.
//

import Foundation
import SwiftData

extension ProjectWindow {
    struct ViewModel {
        func project(with id: PersistentIdentifier?, in context: ModelContext) -> Project? {
            guard let id, let project = context.model(for: id) as? Project else {
                return nil
            }

            return project
        }
    }
}
