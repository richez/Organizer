//
//  AlertType.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 17/10/2023.
//

import Foundation

// TODO: delete invalidContentLink
enum AlertType {
    case unknownError
    case invalidContentLink

    var title: String {
        switch self {
        case .unknownError: "An unknown error occured"
        case .invalidContentLink: "The content link is not valid"
        }
    }

    var message: String {
        switch self {
        case .unknownError: "Please try again later"
        case .invalidContentLink: "Edit link and try again"
        }
    }
}
