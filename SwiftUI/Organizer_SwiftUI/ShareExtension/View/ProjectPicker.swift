//
//  ProjectPicker.swift
//  ShareExtension
//
//  Created by Thibaut Richez on 17/10/2023.
//

import SwiftData
import SwiftUI

struct ProjectPicker: View {
    var configuration: FormTextField.Configuration
    @Binding var title: String
    @Binding var selectedProject: Project?
    @Binding var isInvalid: Bool
    @FocusState.Binding var focusedField: FormTextField.Name?

    @Query(sort: \Project.updatedDate, order: .reverse)
    private var projects: [Project]

    var body: some View {
        FormSection("Project") {
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
                    configuration: self.configuration,
                    text: self.$title,
                    isInvalid: self.$isInvalid,
                    focusedField: self.$focusedField
                )
            }
        }
    }
}
