//
//  ContextMenuType.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 16/10/2023.
//

import Foundation

enum ContextMenuType {
    case duplicate
    case edit
    case delete

    var label: String {
        switch self {
        case .duplicate: "Duplicate"
        case .edit: "Edit"
        case .delete: "Delete"
        }
    }

    var systemName: String {
        switch self {
        case .duplicate: "doc.on.doc"
        case .edit: "square.and.pencil"
        case .delete: "trash"
        }
    }
}
