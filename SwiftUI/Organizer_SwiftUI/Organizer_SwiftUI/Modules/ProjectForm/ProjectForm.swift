//
//  ProjectForm.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 25/10/2023.
//

import SwiftData
import SwiftUI

struct ProjectForm: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @FocusState private var focusedField: FormTextField.Name?
    @State private var viewModel: ViewModel

    init(project: Project? = nil) {
        self._viewModel = State(initialValue: ViewModel(project: project))
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            Form {
                FormSection("Title") {
                    FormTextField(
                        configuration: .projectTitle,
                        text: self.$viewModel.title,
                        isInvalid: self.$viewModel.isInvalidTitle,
                        focusedField: self.$focusedField
                    )
                }

                FormSection("Themes") {
                    FormTextField(
                        configuration: .projectTheme,
                        text: self.$viewModel.theme,
                        isInvalid: self.$viewModel.isInvalidTheme,
                        focusedField: self.$focusedField
                    )
                }
            }
            .onSubmit {
                self.focusedField = self.viewModel.field(after: self.focusedField)
            }

            FloatingButton("Save project", systemName: "checkmark") {
                self.save()
            }
        }
        .scrollDismissesKeyboard(.interactively)
        .scrollContentBackground(.hidden)
        .padding(.top)
        .background(Color.listBackground)
        .alert(.unknownError, isPresented: self.$viewModel.hasUnknownError)
        .onAppear {
            self.viewModel.update()
        }
    }
}

private extension ProjectForm {
    func save() {
        self.focusedField = nil
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
