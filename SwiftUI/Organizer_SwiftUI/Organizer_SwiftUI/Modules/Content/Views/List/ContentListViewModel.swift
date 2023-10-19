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
        enum Error: Swift.Error {
            case invalidURL(String)
        }

        func url(for content: ProjectContent) throws -> URL {
            guard content.link.isValidURL(), let url = URL(string: content.link) else {
                throw Error.invalidURL(content.link)
            }

            return url
        }

        func delete(_ content: ProjectContent, in context: ModelContext) {
            context.delete(content)
        }

        // TODO: could be retrieve directly from project ? Check if added to menu after content creation
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
