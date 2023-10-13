//
//  ContentListType.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 13/10/2023.
//

import Foundation

enum ContentListType: RawRepresentable, Hashable, Identifiable {
    case all
    case custom(ProjectContentType)

    var id: String { self.rawValue }

    var rawValue: String {
        switch self {
        case .all:
            return "All"
        case .custom(let type):
            return type.rawValue
        }
    }

    init?(rawValue: String) {
        switch rawValue {
        case "All":
            self = .all
        default:
            if let type = ProjectContentType(rawValue: rawValue) {
                self = .custom(type)
            } else {
                return nil
            }
        }
    }
}
