//
//  ProjectRowViewModel.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 12/10/2023.
//

import Foundation

extension ProjectRow {
    struct ViewModel {
        func title(of project: Project) -> String {
            project.title
        }

        func themes(of project: Project) -> String {
            project.themes.map { "#\($0)" }.joined(separator: " ")
        }

        func statistics(of project: Project) -> String {
            let contentCount = project.contents.count
            guard contentCount > 0 else { return "" }

            let contentTypeCounts = ProjectContentType.allCases.compactMap { type in
                let contentTypeCount = project.contents.filter { $0.type == type }.count
                return contentTypeCount > 0 ? "\(contentTypeCount) \(type.rawValue)s" : nil
            }.joined(separator: ", ")

            return "\(contentCount) contents (\(contentTypeCounts))"
        }

        func updatedDate(of project: Project) -> String {
            project.updatedDate.formatted(.dateTime.day().month(.abbreviated))
        }
    }
}
