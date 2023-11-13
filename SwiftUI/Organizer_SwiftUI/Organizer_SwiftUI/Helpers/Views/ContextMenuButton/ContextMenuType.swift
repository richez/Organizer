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
        case .duplicate: String(localized: "Duplicate")
        case .edit: String(localized: "Edit")
        case .delete: String(localized: "Delete")
        case .openBrowser: String(localized: "Open in Browser")
        case .copyLink: String(localized: "Copy Link")
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
