//
//  ProjectRowViewModel.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 12/10/2023.
//

import Foundation

extension ProjectRow {
    struct ViewModel {
        func themes(for themes: [String]) -> String {
            themes.map { "#\($0)" }.joined(separator: " ")
        }

        func statistics(for contents: [ProjectContent]) -> String {
            let contentCount = contents.count
            guard contentCount > 0 else { return "" }

            let contentTypeCounts = ProjectContentType.allCases.compactMap { type in
                let contentTypeCount = contents.filter { $0.type == type }.count
                return contentTypeCount > 0 ? "\(contentTypeCount) \(type.rawValue)s" : nil
            }.joined(separator: ", ")

            return "\(contentCount) contents (\(contentTypeCounts))"
        }

        func updatedDate(for updatedDate: Date) -> String {
            updatedDate.formatted(.dateTime.day().month(.abbreviated))
        }
    }
}
