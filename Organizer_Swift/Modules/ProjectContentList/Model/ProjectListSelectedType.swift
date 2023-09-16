//
//  ProjectListSelectedType.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 16/09/2023.
//

import Foundation

enum ProjectListSelectedType: RawRepresentable {
    case all
    case custom(ProjectContentType)

    public var rawValue: String {
        switch self {
        case .all:
            return "all"
        case .custom(let contentType):
            return contentType.rawValue
        }
    }

    public init?(rawValue: String) {
        switch rawValue {
        case "all":
            self = .all
        default:
            if let contentType = ProjectContentType(rawValue: rawValue) {
                self = .custom(contentType)
            } else {
                return nil
            }
        }
    }
}
