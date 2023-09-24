//
//  ShareFormMenuItem.swift
//  ShareExtension
//
//  Created by Thibaut Richez on 25/09/2023.
//

import Foundation

enum ShareFormMenuItem {
    case new(title: String)
    case custom(title: String, id: UUID)

    var title: String {
        switch self {
        case .new(let title):
            return title
        case .custom(let title, _):
            return title
        }
    }

    var isOn: Bool {
        switch self {
        case .new:
            return true
        case .custom:
            return false
        }
    }
}
