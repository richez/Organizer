//
//  ProjectListTheme.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 12/10/2023.
//

import Foundation

enum ProjectListTheme: RawRepresentable, Hashable, Identifiable {
    case all
    case custom(String)

    var id: String { self.rawValue }

    var rawValue: String {
        switch self {
        case .all:
            return "All"
        case .custom(let value):
            return value
        }
    }

    init?(rawValue: String) {
        switch rawValue {
        case "All":
            self = .all
        default:
            self = .custom(rawValue)
        }
    }
}
