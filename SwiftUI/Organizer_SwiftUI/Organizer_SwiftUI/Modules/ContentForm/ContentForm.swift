//
//  ContentForm.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 25/10/2023.
//

import SwiftUI

struct ContentForm: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @FocusState private var focusedField: FormTextField.Name?
    @State private var viewModel: ViewModel

    init(project: Project, content: ProjectContent? = nil) {
        self._viewModel = State(initialValue: ViewModel(project: project, content: content))
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            Form {
                FormSection("Type") {
                    Picker("Type", selection: self.$viewModel.type) {
                        ForEach(ProjectContentType.allCases) { type in
                            Text(type.rawValue)
                                .tag(type)
                        }
                    }
                    .pickerStyle(.segmented)
                }

                FormSection("Link") {
                    FormTextField(
                        configuration: .contentLink,
                        text: self.$viewModel.link,
                        isInvalid: self.$viewModel.isInvalidLink,
                        focusedField: self.$focusedField
                    )
                }

                FormSection("Title") {
                    FormTextField(
                        configuration: .contentTitle,
                        text: self.$viewModel.title,
                        isInvalid: self.$viewModel.isInvalidTitle,
                        focusedField: self.$focusedField
                    )

                    FormLoadingButton(
                        title: "Get link title",
                        isEnabled: self.viewModel.isValidURL,
                        isLoading: self.viewModel.isLoadingTitle) {
                            self.viewModel.shouldLoadTitle = true
                        }
                }

                FormSection("Themes") {
                    FormTextField(
                        configuration: .contentTheme,
                        text: self.$viewModel.theme,
                        isInvalid: self.$viewModel.isInvalidTheme,
                        focusedField: self.$focusedField
                    )
                }
            }
            .onSubmit {
                self.focusedField = self.viewModel.field(after: self.focusedField)
            }

            FloatingButton("Save content", systemName: "checkmark") {
                self.save()
            }
        }
        .allowsHitTesting(!self.viewModel.isLoadingTitle)
        .scrollDismissesKeyboard(.interactively)
        .scrollContentBackground(.hidden)
        .padding(.top)
        .background(Color.listBackground)
        .errorAlert(self.$viewModel.error)
        .onAppear {
            self.viewModel.update()
        }
        .task(id: self.viewModel.shouldLoadTitle) {
            self.focusedField = nil
            await self.viewModel.loadLinkTitle()
        }
    }
}

private extension ContentForm {
    func save() {
        self.focusedField = nil
        self.viewModel.save(in: self.modelContext)
        if self.viewModel.didSaveContent {
            self.dismiss()
        }
    }
}

#Preview("Add content") {
    ModelContainerPreview {
        ContentForm(project: PreviewDataGenerator.project)
            .scrollContentBackground(.hidden)
    }
}

#Preview("Edit content") {
    ModelContainerPreview {
        ContentForm(
            project: PreviewDataGenerator.project,
            content: PreviewDataGenerator.content
        )
        .scrollContentBackground(.hidden)
    }
}
