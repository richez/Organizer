//
//  ContentView.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 13/10/2023.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    var project: Project

    private let viewModel = ViewModel()

    var body: some View {
        ZStack(alignment: .bottom) {
            ContentListView(predicate: self.predicate, sort: self.sortDescriptor)

            FloatingButtonSheet(systemName: "plus") {
                
            }
        }
        .listStyle()
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(self.project.title)
                    .foregroundStyle(.accent)
            }
        }
    }
}

private extension ContentView {
    var sortDescriptor: SortDescriptor<ProjectContent> {
        self.viewModel.sortDescriptor()
    }

    var predicate: Predicate<ProjectContent>? {
        self.viewModel.predicate(for: self.project)
    }
}

extension ContentView {
    struct ViewModel {
        func sortDescriptor() -> SortDescriptor<ProjectContent> {
            SortDescriptor(\.updatedDate)
        }

        func predicate(for project: Project) -> Predicate<ProjectContent>? {
            let projectID = project.persistentModelID
            return #Predicate {
                $0.project?.persistentModelID == projectID
            }
        }
    }
}

#Preview {
    ModelContainerPreview {
        NavigationStack {
            ContentView(project: PreviewDataGenerator.project)
        }
    }
}
