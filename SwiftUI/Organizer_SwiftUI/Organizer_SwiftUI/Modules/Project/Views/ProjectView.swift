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
        .navigationBarTitleDisplayMode(.inline)
        .background(Color.listBackground)
        .scrollContentBackground(.hidden)
        .toolbarBackground(.listBackground)
        .toolbarBackground(.visible)
    }
}

private extension ProjectView {
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
    NavigationStack {
        ProjectView()
    }
    .previewModelContainer()
}
