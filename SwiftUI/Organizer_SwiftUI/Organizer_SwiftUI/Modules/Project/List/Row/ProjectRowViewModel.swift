//
//  ProjectRowViewModel.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 12/10/2023.
//

import Foundation

extension ProjectRow {
    struct ViewModel {
        func updatedDate(of project: Project) -> String {
            project.updatedDate.formatted(.dateTime.day().month(.abbreviated))
        }
    }
}
