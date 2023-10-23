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
    @State private var isLoadingTitle: Bool = false

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
                        configuration: .contentLink,
                        text: self.$link,
                        isInvalid: self.$isInvalidLink,
                        focusedField: self.$focusedField
                    )
                }

                FormSection("Title") {
                    FormTextField(
                        configuration: .contentTitle,
                        text: self.$title,
                        isInvalid: self.$isInvalidTitle,
                        focusedField: self.$focusedField
                    )

                    FormLoadingButton(
                        title: "Get link title",
                        isEnabled: self.isValidLink,
                        isLoading: self.isLoadingTitle) {
                            self.isLoadingTitle = true
                        }
                }

                FormSection("Themes") {
                    FormTextField(
                        configuration: .contentTheme,
                        text: self.$theme,
                        isInvalid: self.$isInvalidTheme,
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
        .allowsHitTesting(!self.isLoadingTitle)
        .scrollDismissesKeyboard(.interactively)
        .scrollContentBackground(.hidden)
        .padding(.top)
        .background(Color.listBackground)
        .alert(.unknownError, isPresented: self.$isShowingErrorAlert)
        .onAppear {
            self.update(with: self.content)
        }
        .task(id: self.isLoadingTitle) {
            await self.loadLinkTitle()
        }
    }
}

private extension ContentForm {
    var values: ContentValues {
        .init(
            type: self.type,
            link: self.link,
            title: self.title,
            theme: self.theme
        )
    }

    var isValidLink: Bool {
        self.viewModel.isValidURL(self.link)
    }

    func save() {
        do {
            self.focusedField = nil
            try self.viewModel.save(
                self.values, 
                for: self.content,
                in: self.project,
                context: self.modelContext
            )
            self.dismiss()
        } catch FormFieldValidator.Error.invalidFields(let fields) {
            self.isInvalidLink = fields.contains(.link)
            self.isInvalidTitle = fields.contains(.title)
            self.isInvalidTheme = fields.contains(.theme)
        } catch {
            self.isShowingErrorAlert = true
        }
    }

    func update(with content: ProjectContent?) {
        if let content {
            self.type = content.type
            self.link = content.link
            self.title = content.title
            self.theme = content.theme
        }
    }

    func loadLinkTitle() async {
        guard self.isLoadingTitle else { return }

        do {
            self.focusedField = nil
            let linkTitle = try await self.viewModel.title(of: self.link)
            try Task.checkCancellation()
            self.title = linkTitle
            self.isLoadingTitle = false
        } catch {
            self.isLoadingTitle = false
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
