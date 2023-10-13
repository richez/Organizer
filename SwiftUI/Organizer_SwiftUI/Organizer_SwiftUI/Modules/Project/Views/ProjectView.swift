//
//  ProjectView.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 12/10/2023.
//

import SwiftUI

struct ProjectView: View {
    private let viewModel = ViewModel()
    
    @AppStorage(StorageKey.projectListSorting.rawValue)
    private var sorting: ProjectListSorting = .updatedDate

    @AppStorage(StorageKey.projectListAscendingOrder.rawValue)
    private var isAscendingOrder: Bool = true

    @AppStorage(StorageKey.projectListSelectedTheme.rawValue)
    private var selectedTheme: ProjectListTheme = .all

    var body: some View {
        ZStack(alignment: .bottom) {
            ProjectListView(predicate: self.predicate, sort: self.sortDescriptor)

            FloatingButtonSheet(systemName: "square.and.pencil") {
                ProjectForm()
            }
        }
        .listStyle()
        .toolbar {
            ToolbarItem(placement: .principal) {
                VStack {
                    Text(self.viewModel.navbarTitle)
                        .font(.headline)
                    Text(self.navbarSubtitle)
                        .font(.subheadline)
                }
                .foregroundStyle(.accent)
            }
        }
    }
}

private extension ProjectView {
    var navbarSubtitle: String {
        self.viewModel.navbarSubtitle(for: self.selectedTheme)
    }

    var sortDescriptor: SortDescriptor<Project> {
        self.viewModel.sortDescriptor(
            sorting: self.sorting, isAscendingOrder: self.isAscendingOrder
        )
    }

    var predicate: Predicate<Project>? {
        self.viewModel.predicate(selectedTeme: self.selectedTheme)
    }
}

#Preview {
    ModelContainerPreview {
        NavigationStack {
            ProjectView()
        }
    }
}
