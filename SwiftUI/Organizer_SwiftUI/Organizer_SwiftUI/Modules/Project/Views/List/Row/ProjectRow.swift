//
//  ProjectRow.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 11/10/2023.
//

import SwiftData
import SwiftUI

struct ProjectRow: View {
    var project: Project
    private let viewModel = ViewModel()

    @AppStorage(StorageKey.projectListShowTheme.rawValue)
    private var showTheme: Bool = true

    @AppStorage(StorageKey.projectListShowStatistics.rawValue)
    private var showStatistics: Bool = true

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(self.title)
                .font(.system(size: 15, weight: .bold))
                .foregroundStyle(.cellTitle)

            VStack(alignment: .leading, spacing: 5) {
                if self.showTheme {
                    Text(self.themes)
                }

                if self.showStatistics {
                    Text(self.statistics)
                }
            }
            .font(.system(size: 12))
            .foregroundStyle(.cellSubtitle)

            Text(self.updatedDate)
                .font(.system(size: 12, weight: .light))
                .foregroundStyle(.cellDate)
        }
    }
}

private extension ProjectRow {
    var title: String {
        self.viewModel.title(of: self.project)
    }

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
    ModelContainerPreview {
        List {
            ProjectRow(project: PreviewDataGenerator.project)
                .listRowBackground(Color.listBackground)
        }
        .listStyle()
    }
}
