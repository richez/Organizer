//
//  ProjectRow.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 11/10/2023.
//

import SwiftUI

struct ProjectRow: View {
    var project: Project

    private let viewModel = ViewModel()

    @AppStorage(StorageKey.projectListShowTheme.rawValue)
    private var showTheme: Bool = true

    @AppStorage(StorageKey.projectListShowStatistics.rawValue)
    private var showStatistics: Bool = true

    var body: some View {
        VStack(alignment: .leading) {
            Text(self.project.title)
                .font(.headline)

            if self.showTheme {
                Text(self.themes)
                    .font(.subheadline)
            }

            if self.showStatistics {
                Text(self.statistics)
                    .font(.footnote)
            }

            Text(self.updatedDate)
                .font(.footnote)
        }
        .foregroundStyle(.white)
    }
}

private extension ProjectRow {
    var themes: String {
        self.viewModel.themes(of: self.project)
    }

    var statistics: String {
        self.viewModel.statistics(of: self.project)
    }

    var updatedDate: String {
        self.viewModel.updatedDate(of: self.project)
    }
}

#Preview {
    return ProjectRow(project: Project.sample[0])
}
