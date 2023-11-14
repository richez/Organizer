//
//  ProjectPicker.swift
//  ShareExtension
//
//  Created by Thibaut Richez on 17/10/2023.
//

import SwiftData
import SwiftUI

struct ProjectPicker: View {
    @Binding var title: String
    @Binding var isInvalid: Bool
    @Binding var selectedProject: Project?
    @FocusState.Binding var focusedField: FormTextField.Name?

    @Query(sort: \Project.updatedDate, order: .reverse)
    private var projects: [Project]

    var body: some View {
        Picker("Project", selection: self.$selectedProject) {
            Text("New")
                .tag(nil as Project?)
            ForEach(self.projects) { project in
                Text(project.title)
                    .tag(project as Project?)
            }
        }

        if selectedProject == nil {
            FormTextField(
                configuration: .projectPicker,
                text: self.$title,
                isInvalid: self.$isInvalid,
                focusedField: self.$focusedField
            )
        }
    }
}
