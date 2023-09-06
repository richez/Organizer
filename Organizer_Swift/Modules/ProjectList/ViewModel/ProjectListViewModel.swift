//
//  ProjectListViewModel.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 05/09/2023.
//

import Foundation

struct ProjectListViewModel {
    var navigationBarTitle: String = "Projects"

    func fetchProjectListDataStore() -> ProjectListDataStore {
        return ProjectListDataStore(projects: Project.sample)
    }
}
