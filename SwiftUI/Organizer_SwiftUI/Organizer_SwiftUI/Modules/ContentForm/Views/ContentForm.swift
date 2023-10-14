//
//  ContentForm.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 14/10/2023.
//

import SwiftUI

struct ContentForm: View {
    var project: Project
    var content: ProjectContent?

    private let viewModel = ViewModel()

    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    @State private var type: ProjectContentType = .article
    @State private var link: String = ""
    @State private var title: String = ""
    @State private var theme: String = ""
    @State private var isInvalidLink: Bool = false
    @State private var isInvalidTitle: Bool = false
    @State private var isInvalidTheme: Bool = false
    @FocusState private var focusedField: FormTextField.Name?

    @State private var isShowingErrorAlert: Bool = false

    var body: some View {
        ZStack(alignment: .bottom) {
            Form {
                FormSection("Type") {
                    Picker("Type", selection: self.$type) {
                        ForEach(ProjectContentType.allCases) { type in
                            Text(type.rawValue)
                                .tag(type)
                        }
                    }
                    .pickerStyle(.segmented)
                }

                FormSection("Link") {
                    FormTextField(
                        configuration: self.viewModel.linkConfiguration,
                        text: self.$link,
                        isInvalid: self.$isInvalidLink,
                        focusedField: self.$focusedField
                    )
                }

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
        .onChange(of: self.type) {} // unused but fixes picker type updates.
        .onAppear {
            if let content {
                self.type = content.type
                self.link = content.link
                self.title = content.title
                self.theme = content.theme
            }
        }
    }
}

private extension ContentForm {
    var values: Values {
        .init(
            type: self.type,
            link: self.link,
            title: self.title,
            theme: self.theme
        )
    }

    func commit() {
        do {
            self.focusedField = nil
            try self.viewModel.save(
                self.values, 
                for: self.content,
                in: self.project,
                context: self.modelContext
            )
            self.dismiss()
        } catch ViewModel.Error.invalidFields(let fields) {
            self.isInvalidLink = fields.contains(.link)
            self.isInvalidTitle = fields.contains(.title)
            self.isInvalidTheme = fields.contains(.theme)
        } catch {
            self.isShowingErrorAlert = true
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
