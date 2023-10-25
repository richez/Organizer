//
//  ProjectHeaderView.swift
//  MacOrganizer
//
//  Created by Thibaut Richez on 18/10/2023.
//

import SwiftUI

struct ProjectHeaderView: View {
    @Environment(NavigationContext.self) private var navigationContext
    @State private var isEditingProject: Project?

    @AppStorage(.projectListSelectedTheme)
    private var selectedTheme: String? = nil

    var body: some View {
        @Bindable var navigationContext = self.navigationContext
        HStack {
            Menu {
                ProjectListSortingMenu()
                ProjectListPreviewStyleMenu()
            } label: {
                Text(self.selectedTheme ?? "Projects")
                    .font(.system(size: 15, weight: .heavy))
            }
            .menuStyle(.borderlessButton)
            .fixedSize(horizontal: true, vertical: false)
            .tint(.cellTitle)

            Spacer()

            Button("Add project", systemImage: "square.and.pencil") {
                self.navigationContext.isShowingProjectForm.toggle()
            }
            .buttonStyle(.borderless)
            .labelStyle(.iconOnly)
            .foregroundStyle(.cellTitle.opacity(0.8))
            .font(.system(size: 18, weight: .bold))
        }
        .padding([.leading, .trailing])
        .focusedSceneValue(\.isShowingProjectForm, $navigationContext.isShowingProjectForm)
        .sheet(isPresented: $navigationContext.isShowingProjectForm) {
            ProjectForm()
        }
        .focusedSceneValue(\.isEditingProject, self.$isEditingProject)
        .sheet(item: self.$isEditingProject) { project in
            ProjectForm(project: project)
        }
    }
}

#Preview {
    ProjectHeaderView()
        .background(.listBackground)
}
