//
//  ContentListSelectedTheme.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 16/09/2023.
//

import Foundation

enum ContentListSelectedTheme: RawRepresentable {
    case all
    case custom(String)

    public var rawValue: String {
        switch self {
        case .all:
            return "all"
        case .custom(let value):
            return value
        }
    }

    public init?(rawValue: String) {
        switch rawValue {
        case "all":
            self = .all
        default:
            self = .custom(rawValue)
        }
    }
}
