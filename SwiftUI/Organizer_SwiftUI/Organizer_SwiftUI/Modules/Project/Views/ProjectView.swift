//
//  ProjectView.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 12/10/2023.
//

import SwiftUI

struct ProjectView: View {
    @Binding var selectedProject: Project?
    @Binding var isShowingForm: Bool

    private let store: ProjectStoreDescriptor = ProjectStore.shared

    @AppStorage(.projectListSelectedTheme)
    private var selectedTheme: String? = nil

    var body: some View {
        ZStack(alignment: .bottom) {
            ProjectListContainerView(selected: self.$selectedProject)

            FloatingButton("Add project", systemName: "square.and.pencil") {
                self.isShowingForm.toggle()
            }
            .sheet(isPresented: self.$isShowingForm) {
                ProjectForm()
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                VStack {
                    Text("Projects")
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
        self.store.filtersDescription(for: self.selectedTheme)
    }
}

#Preview {
    ModelContainerPreview {
        NavigationStack {
            ProjectView(selectedProject: .constant(nil), isShowingForm: .constant(false))
        }
    }
}
