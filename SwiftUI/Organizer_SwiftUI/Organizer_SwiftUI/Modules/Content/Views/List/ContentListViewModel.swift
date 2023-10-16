//
//  ContentListViewModel.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 13/10/2023.
//

import Foundation
import SwiftData

extension ContentListView {
    struct ViewModel {
        func delete(_ content: ProjectContent, in context: ModelContext) {
            context.delete(content)
        }

        func themes(in project: Project?, context: ModelContext) -> [String] {
            guard let project else { return [] }

            let projectID = project.persistentModelID
            var descriptor = FetchDescriptor<ProjectContent>(predicate: #Predicate {
                $0.project?.persistentModelID == projectID
            })
            descriptor.propertiesToFetch = [\.theme]
            let projectContents = (try? context.fetch(descriptor)) ?? []
            return projectContents.flatMap(\.themes).removingDuplicates()
        }
    }
}
