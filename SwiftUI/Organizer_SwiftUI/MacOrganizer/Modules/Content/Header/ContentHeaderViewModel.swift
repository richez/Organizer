//
//  ContentHeaderViewModel.swift
//  MacOrganizer
//
//  Created by Thibaut Richez on 19/10/2023.
//

import Foundation

extension ContentHeaderView {
    struct ViewModel {
        func themes(in project: Project) -> [String] {
            return project.contents
                .flatMap(\.themes)
                .removingDuplicates()
        }
    }
}
