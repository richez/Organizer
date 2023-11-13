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

    var title: LocalizedStringKey {
        switch self {
        case .delete: "Delete"
        case .edit: "Edit"
        }
    }

    var systemName: String {
        switch self {
        case .delete: "trash"
        case .edit: "square.and.pencil"
        }
    }

    var tint: Color {
        switch self {
        case .delete: .swipeDeleteTint
        case .edit: .swipeEditTint
        }
    }
}
