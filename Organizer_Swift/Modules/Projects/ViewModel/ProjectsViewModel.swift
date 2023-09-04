//
//  ProjectsViewModel.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 05/09/2023.
//

import Foundation

protocol ProjectsViewModelProtocol {
    var navigationBarTitle: String { get }
}

struct ProjectsViewModel {
}

extension ProjectsViewModel: ProjectsViewModelProtocol {
    var navigationBarTitle: String { "Projects" }
}
