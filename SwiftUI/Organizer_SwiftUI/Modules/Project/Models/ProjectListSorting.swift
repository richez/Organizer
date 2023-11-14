//
//  ProjectListSorting.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 12/10/2023.
//

import Foundation

enum ProjectListSorting: String, Identifiable, CaseIterable {
    case updatedDate = "Modification Date"
    case createdDate = "Creation Date"
    case title = "Title"

    var name: LocalizedStringResource {
        switch self {
        case .updatedDate: "Modification Date"
        case .createdDate: "Creation Date"
        case .title: "Title"
        }
    }

    var id: ProjectListSorting { self }
}
