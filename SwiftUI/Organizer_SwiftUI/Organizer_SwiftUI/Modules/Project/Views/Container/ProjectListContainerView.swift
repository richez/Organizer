//
//  ProjectListContainerView.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 18/10/2023.
//

import SwiftUI

struct ProjectListContainerView: View {
    private let viewModel = ViewModel()

    @Environment(NavigationContext.self) private var navigationContext

    @AppStorage(.projectListSorting)
    private var sorting: ProjectListSorting = .updatedDate

    @AppStorage(.projectListAscendingOrder)
    private var isAscendingOrder: Bool = true

    @AppStorage(.projectListSelectedTheme)
    private var selectedTheme: String? = nil

    var body: some View {
        ProjectListView(
            predicate: self.predicate,
            sort: self.sortDescriptor
        )
        .listStyle()
        .onChange(of: self.selectedTheme) {
            self.navigationContext.selectedProject = nil
        }
    }
}

private extension ProjectListContainerView {
    var sortDescriptor: SortDescriptor<Project> {
        self.viewModel.sortDescriptor(with: self.sorting, isAscending: self.isAscendingOrder)
    }

    var predicate: Predicate<Project>? {
        self.viewModel.predicate(with: self.selectedTheme)
    }
}

#Preview {
    ModelContainerPreview {
        NavigationStack {
            ProjectListContainerView()
                .listStyle()
        }
    }
}
