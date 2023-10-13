//
//  SwipeActionType.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 13/10/2023.
//

import SwiftUI

enum SwipeActionType {
    case delete
    case edit

    var systemName: String {
        switch self {
        case .delete:
            return "trash"
        case .edit:
            return "square.and.pencil"
        }
    }

    var tint: Color {
        switch self {
        case .delete:
            return .swipeDeleteTint
        case .edit:
            return .swipeEditTint
        }
    }
}
