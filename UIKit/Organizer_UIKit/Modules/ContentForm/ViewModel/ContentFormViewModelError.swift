//
//  ContentFormViewModelError.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 27/09/2023.
//

import Foundation

enum ContentFormViewModelError: RenderableError {
    case urlMetadataProvider(String, Error)

    var title: String { "Fail to retrieve link title" }
    var message: String {
        switch self {
        case .urlMetadataProvider(let link, _):
            "Please verify link (\(link)) and try again"
        }
    }
    var actionTitle: String { "OK" }
}
