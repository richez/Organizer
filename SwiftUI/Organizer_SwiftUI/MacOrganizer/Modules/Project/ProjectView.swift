//
//  ProjectView.swift
//  MacOrganizer
//
//  Created by Thibaut Richez on 18/10/2023.
//

import SwiftUI

struct ProjectView: View {
    @Binding var selectedProject: Project?
    @Binding var isShowingForm: Bool

    var body: some View {
        VStack {
            ProjectHeaderView(isShowingForm: self.$isShowingForm)
            ProjectListContainerView(selected: self.$selectedProject)
        }
        .focusedSceneValue(\.selectedProject, self.$selectedProject)
    }
}

#Preview {
    ModelContainerPreview {
        NavigationStack {
            ProjectView(selectedProject: .constant(nil), isShowingForm: .constant(false))
                .background(.listBackground)
        }
    }
}
