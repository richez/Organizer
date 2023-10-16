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
    case openBrowser
    case copyLink

    var label: String {
        switch self {
        case .duplicate: "Duplicate"
        case .edit: "Edit"
        case .delete: "Delete"
        case .openBrowser: "Open in Browser"
        case .copyLink: "Copy Link"
        }
    }

    var systemName: String {
        switch self {
        case .duplicate: "doc.on.doc"
        case .edit: "square.and.pencil"
        case .delete: "trash"
        case .openBrowser: "safari"
        case .copyLink: "doc.on.doc"
        }
    }
}
