//
//  AlertType.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 17/10/2023.
//

import Foundation

enum AlertType {
    case unknownError

    var title: String {
        switch self {
        case .unknownError: "An unknown error occured"
        }
    }

    var message: String {
        switch self {
        case .unknownError: "Please try again later"
        }
    }
}
