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

        // TODO: sort theme
        func themes(in project: Project?) -> [String] {
            guard let project else { return [] }
            return project.contents
                .flatMap(\.themes)
                .removingDuplicates()
        }
    }
}
