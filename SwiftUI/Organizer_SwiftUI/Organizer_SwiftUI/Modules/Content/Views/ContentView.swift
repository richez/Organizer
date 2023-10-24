//
//  ContentView.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 13/10/2023.
//

import SwiftUI

struct ContentView: View {
    var project: Project

    private let store: ContentStoreDescriptor = ContentStore.shared

    @Environment(NavigationContext.self) private var navigationContext

    @AppStorage(.contentListSelectedTheme)
    private var selectedTheme: String? = nil

    @AppStorage(.contentListSelectedType)
    private var selectedType: ProjectContentType?

    init(project: Project) {
        self.project = project

        let defaults = UserDefaults(suiteName: project.identifier.uuidString)
        self._selectedTheme.update(with: defaults, key: .contentListSelectedTheme)
        self._selectedType.update(with: defaults, key: .contentListSelectedType)
    }

    var body: some View {
        @Bindable var navigationContext = self.navigationContext
        ZStack(alignment: .bottom) {
            ContentListContainerView(project: self.project)

            FloatingButton("Add content", systemName: "plus") {
                self.navigationContext.isShowingContentForm.toggle()
            }
            .sheet(isPresented: $navigationContext.isShowingContentForm) {
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
            ContentView(project: PreviewDataGenerator.project)
        }
    }
}
