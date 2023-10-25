//
//  ProjectForm.swift
//  MacOrganizer
//
//  Created by Thibaut Richez on 18/10/2023.
//

import SwiftUI

struct ProjectForm: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @State private var viewModel: ViewModel

    init(project: Project? = nil) {
        self._viewModel = State(initialValue: ViewModel(project: project))
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            FormSaveButton {
                self.save()
            }

            Form {
                FormTextField(
                    configuration: .projectTitle,
                    text: self.$viewModel.title,
                    isInvalid: self.$viewModel.isInvalidTitle
                )

                FormTextField(
                    configuration: .projectTheme,
                    text: self.$viewModel.theme,
                    isInvalid: self.$viewModel.isInvalidTheme
                )
            }
            .foregroundStyle(.white)
        }
        .padding()
        .frame(minWidth: 300, maxWidth: 300, minHeight: 150, maxHeight: 150)
        .background(.listBackground)
        .errorAlert(self.$viewModel.error)
        .onAppear {
            self.viewModel.update()
        }
    }
}

private extension ProjectForm {
    func save() {
        self.viewModel.save(in: self.modelContext)
        if self.viewModel.didSaveProject {
            self.dismiss()
        }
    }
}

#Preview("Add project") {
    ModelContainerPreview {
        ProjectForm()
            .scrollContentBackground(.hidden)
    }
}

#Preview("Edit project") {
    ModelContainerPreview {
        ProjectForm(project: PreviewDataGenerator.project)
            .scrollContentBackground(.hidden)
    }
}
