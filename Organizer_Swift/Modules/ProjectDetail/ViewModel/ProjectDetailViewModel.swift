//
//  ProjectDetailViewModel.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 11/09/2023.
//

import Foundation

struct ProjectDetailViewModel {
    private let project: Project

    init(project: Project) {
        self.project = project
    }
}

// MARK: - Public

extension ProjectDetailViewModel {
    var navigationBarTitle: String { self.project.title }
}
