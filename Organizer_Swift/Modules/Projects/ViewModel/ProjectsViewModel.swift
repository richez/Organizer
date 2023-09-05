//
//  ProjectsViewModel.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 05/09/2023.
//

import Foundation

struct ProjectsViewModel {
    var navigationBarTitle: String = "Projects"

    func fetchProjectsDataStore() -> ProjectsDataStore {
        return ProjectsDataStore(projects: Projects.sample)
    }
}
