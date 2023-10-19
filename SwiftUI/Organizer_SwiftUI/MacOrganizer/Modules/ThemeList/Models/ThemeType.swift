//
//  ThemeType.swift
//  MacOrganizer
//
//  Created by Thibaut Richez on 19/10/2023.
//

import Foundation

enum ThemeType {
    case all
    case custom(String)

    var systemImage: String {
        switch self {
        case .all: "doc.text.fill"
        case .custom: "number"
        }
    }

    var theme: String? {
        switch self {
        case .all: nil
        case .custom(let theme): theme
        }
    }
}

extension ThemeType: RawRepresentable, Hashable {
    var rawValue: String {
        switch self {
        case .all: "Projects"
        case .custom(let theme): theme
        }
    }

    init?(rawValue: String) {
        switch rawValue {
        case "Projects":
            self = .all
        default:
            self = .custom(rawValue)
        }
    }
}

extension ThemeType: Identifiable {
    var id: ThemeType { self }
}
