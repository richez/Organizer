//
//  ProjectForm.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 12/10/2023.
//

import SwiftData
import SwiftUI

struct ProjectForm: View {
    var project: Project?

    private let viewModel = ViewModel()

    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    @State private var title: String = ""
    @State private var theme: String = ""
    @State private var isInvalidTitle: Bool = false
    @State private var isInvalidTheme: Bool = false
    @FocusState private var focusedField: FormTextField.Name?

    @State private var isShowingErrorAlert: Bool = false

    var body: some View {
        ZStack(alignment: .bottom) {
            Form {
                FormSection("Name") {
                    FormTextField(
                        configuration: self.viewModel.titleConfiguration,
                        text: self.$title,
                        isInvalid: self.$isInvalidTitle,
                        focusedField: self.$focusedField
                    )
                }

                FormSection("Themes") {
                    FormTextField(
                        configuration: self.viewModel.themeConfiguration,
                        text: self.$theme,
                        isInvalid: self.$isInvalidTheme,
                        focusedField: self.$focusedField
                    )
                }
            }
            .onSubmit {
                self.focusedField = self.viewModel.field(after: self.focusedField)
            }

            FloatingButton(systemName: "checkmark") {
                self.commit()
            }
            .alert("An unknown error occured", isPresented: self.$isShowingErrorAlert) {
            } message: {
                Text("Please try again later")
            }
        }
        .padding(.top)
        .background(Color.listBackground)
        .onAppear {
            if let project {
                self.title = project.title
                self.theme = project.theme
            }
        }
    }
}

private extension ProjectForm {
    var values: ProjectForm.Values {
        .init(title: self.title, theme: self.theme)
    }

    func commit() {
        do {
            self.focusedField = nil
            try self.viewModel.save(
                self.values, for: self.project, in: self.modelContext
            )
            self.dismiss()
        } catch ViewModel.Error.invalidFields(let fields) {
            self.isInvalidTitle = fields.contains(.title)
            self.isInvalidTheme = fields.contains(.theme)
        } catch {
            self.isShowingErrorAlert = true
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
