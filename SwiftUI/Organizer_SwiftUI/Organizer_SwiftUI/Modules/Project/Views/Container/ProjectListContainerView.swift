//
//  ProjectListContainerView.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 18/10/2023.
//

import SwiftUI

struct ProjectListContainerView: View {
    @Binding var selected: Project?

    private let store: ProjectStoreDescriptor = ProjectStore()

    @AppStorage(.projectListSorting)
    private var sorting: ProjectListSorting = .updatedDate

    @AppStorage(.projectListAscendingOrder)
    private var isAscendingOrder: Bool = true

    @AppStorage(.projectListSelectedTheme)
    private var selectedTheme: String? = nil

    var body: some View {
        ProjectListView(
            selected: self.$selected,
            predicate: self.predicate,
            sort: self.sortDescriptor
        )
        .listStyle()
        .onChange(of: self.selectedTheme) {
            self.selected = nil
        }
    }
}

private extension ProjectListContainerView {
    var sortDescriptor: SortDescriptor<Project> {
        self.store.sortDescriptor(
            sorting: self.sorting,
            isAscendingOrder: self.isAscendingOrder
        )
    }

    var predicate: Predicate<Project>? {
        self.store.predicate(selectedTeme: self.selectedTheme)
    }
}

#Preview {
    ModelContainerPreview {
        NavigationStack {
            ProjectListContainerView(selected: .constant(nil))
                .listStyle()
        }
    }
}
