//
//  ContentView.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 13/10/2023.
//

import SwiftUI

struct ContentView: View {
    var project: Project
    @Binding var selected: ProjectContent?

    private let store: ContentStoreDescriptor = ContentStore.shared

    @AppStorage(.contentListSelectedTheme)
    private var selectedTheme: String? = nil

    @AppStorage(.contentListSelectedType)
    private var selectedType: ProjectContentType?

    @State var isShowingForm: Bool = false

    init(project: Project, selected: Binding<ProjectContent?>) {
        self.project = project
        self._selected = selected

        let defaults = UserDefaults(suiteName: project.identifier.uuidString)
        self._selectedTheme.update(with: defaults, key: .contentListSelectedTheme)
        self._selectedType.update(with: defaults, key: .contentListSelectedType)
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            ContentListContainerView(project: self.project, selected: self.$selected)

            FloatingButton("Add content", systemName: "plus") {
                self.isShowingForm.toggle()
            }
            .sheet(isPresented: self.$isShowingForm) {
                ContentForm(project: self.project)
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                VStack {
                    Text(self.project.title)
                        .font(.headline)
                    Text(self.navbarSubtitle)
                        .font(.subheadline)
                }
                .foregroundStyle(.accent)
            }
        }
    }
}

private extension ContentView {
    var navbarSubtitle: String {
        self.store.filtersDescription(
            for: self.selectedTheme,
            selectedType: self.selectedType
        )
    }
}

#Preview {
    ModelContainerPreview {
        NavigationStack {
            ContentView(project: PreviewDataGenerator.project, selected: .constant(nil))
        }
    }
}
