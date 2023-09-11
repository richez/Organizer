//
//  ProjectContentViewModel.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 11/09/2023.
//

import Foundation

struct ProjectContentViewModel {
    private let project: Project

    init(project: Project) {
        self.project = project
    }
}

// MARK: - Public

extension ProjectContentViewModel {
    var navigationBarTitle: String { self.project.title }
}
