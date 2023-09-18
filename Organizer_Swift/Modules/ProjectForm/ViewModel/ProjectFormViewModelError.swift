//
//  ProjectFormViewModelError.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 14/09/2023.
//

import Foundation

enum ProjectFormViewModelError: RenderableError {
    case create(Error)

    var title: String { "Fail to create project" }
    var message: String { "Please try again later" }
    var actionTitle: String { "OK" }
}
