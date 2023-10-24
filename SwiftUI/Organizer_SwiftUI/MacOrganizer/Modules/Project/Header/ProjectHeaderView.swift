//
//  ProjectHeaderView.swift
//  MacOrganizer
//
//  Created by Thibaut Richez on 18/10/2023.
//

import SwiftUI

struct ProjectHeaderView: View {
    @State private var isShowingForm: Bool = false
    @State private var isShowingEditorForm: Project?

    @AppStorage(.projectListSelectedTheme)
    private var selectedTheme: String? = nil

    var body: some View {
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
                self.isShowingForm.toggle()
            }
            .buttonStyle(.borderless)
            .labelStyle(.iconOnly)
            .foregroundStyle(.cellTitle.opacity(0.8))
            .font(.system(size: 18, weight: .bold))
        }
        .padding([.leading, .trailing])
        .focusedSceneValue(\.showProjectForm, self.$isShowingForm)
        .sheet(isPresented: self.$isShowingForm) {
            ProjectForm()
        }
        .focusedSceneValue(\.showProjectEditorForm, self.$isShowingEditorForm)
        .sheet(item: self.$isShowingEditorForm) { project in
            ProjectForm(project: project)
        }
    }
}

#Preview {
    ProjectHeaderView()
        .background(.listBackground)
}
