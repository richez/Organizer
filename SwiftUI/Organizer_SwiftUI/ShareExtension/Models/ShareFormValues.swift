//
//  ShareFormValues.swift
//  ShareExtension
//
//  Created by Thibaut Richez on 17/10/2023.
//

import Foundation

extension ShareForm {
    enum SelectedProject {
        case new(String)
        case custom(Project)
    }

    struct Values {
        var project: SelectedProject
        var type: ProjectContentType
        var link: String
        var title: String
        var theme: String
    }
}
