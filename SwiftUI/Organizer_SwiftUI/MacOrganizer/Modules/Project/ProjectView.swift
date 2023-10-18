//
//  ProjectView.swift
//  MacOrganizer
//
//  Created by Thibaut Richez on 18/10/2023.
//

import SwiftUI

struct ProjectView: View {
    private let viewModel = ViewModel()

    @AppStorage(.projectListSorting)
    private var sorting: ProjectListSorting = .updatedDate

    @AppStorage(.projectListAscendingOrder)
    private var isAscendingOrder: Bool = true

    @AppStorage(.projectListSelectedTheme)
    private var selectedTheme: String? = nil

    var body: some View {
        ProjectListView(predicate: self.predicate, sort: self.sortDescriptor)
            .listStyle()
            .toolbar {
                ToolbarItem {
                    Text("Projects")
                        .font(.headline)
                }
            }
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
    ModelContainerPreview {
        NavigationStack {
            ProjectView()
        }
    }
}


// MARK: - Placeholders

struct ContentView: View {
    var project: Project

    var body: some View {
        List {
            ForEach(0..<15) { index in
                Text("Cell \(index)")
            }
        }
        .toolbar {
            ToolbarItem {
                Text(self.project.title)
                    .font(.headline)
            }
        }
    }
}

struct ProjectRow: View {
    var project: Project

    var body: some View {
        Text(self.project.title)
    }
}

struct ProjectForm: View {
    var project: Project

    var body: some View {
        Text(self.project.title)
    }
}

struct ListStyleViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(Color.listBackground)
            .scrollContentBackground(.hidden)
            .toolbarBackground(.listBackground)
            .toolbarBackground(.visible)
    }
}

extension View {
    func listStyle() -> some View {
        self.modifier(ListStyleViewModifier())
    }
}
