//
//  ProjectForm.swift
//  MacOrganizer
//
//  Created by Thibaut Richez on 18/10/2023.
//

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
    @State private var isShowingErrorAlert: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            FormSaveButton {
                self.save()
            }

            Form {
                FormTextField(
                    configuration: .projectTitle,
                    text: self.$title,
                    isInvalid: self.$isInvalidTitle
                )

                FormTextField(
                    configuration: .projectTheme,
                    text: self.$theme,
                    isInvalid: self.$isInvalidTheme
                )
            }
            .foregroundStyle(.white)
        }
        .padding()
        .frame(minWidth: 300, maxWidth: 300, minHeight: 150, maxHeight: 150)
        .background(.listBackground)
        .alert(.unknownError, isPresented: self.$isShowingErrorAlert)
        .onAppear {
            self.update(with: self.project)
        }
    }
}

private extension ProjectForm {
    var values: ProjectValues {
        .init(title: self.title, theme: self.theme)
    }

    func save() {
        do {
            try self.viewModel.save(
                self.values, for: self.project, in: self.modelContext
            )
            self.dismiss()
        } catch FormFieldValidator.Error.invalidFields(let fields) {
            self.isInvalidTitle = fields.contains(.title)
            self.isInvalidTheme = fields.contains(.theme)
        } catch {
            self.isShowingErrorAlert = true
        }
    }

    func update(with project: Project?) {
        if let project {
            self.title = project.title
            self.theme = project.theme
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
