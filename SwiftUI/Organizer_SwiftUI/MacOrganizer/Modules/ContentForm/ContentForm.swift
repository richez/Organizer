//
//  ContentForm.swift
//  MacOrganizer
//
//  Created by Thibaut Richez on 19/10/2023.
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

    @State private var isShowingErrorAlert: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            FormSaveButton {
                self.save()
            }

            Form {
                Picker("Type", selection: self.$type) {
                    ForEach(ProjectContentType.allCases) { type in
                        Text(type.rawValue)
                            .tag(type)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.bottom)
                .preferredColorScheme(.dark)

                FormTextField(
                    configuration: .contentLink,
                    text: self.$link,
                    isInvalid: self.$isInvalidLink
                )

                FormTextField(
                    configuration: .contentTitle,
                    text: self.$title,
                    isInvalid: self.$isInvalidTitle
                )

                FormTextField(
                    configuration: .contentTheme,
                    text: self.$theme,
                    isInvalid: self.$isInvalidTheme
                )
            }
            .foregroundStyle(.white)
        }
        .padding()
        .frame(minWidth: 400, maxWidth: 400, minHeight: 250, maxHeight: 250)
        .background(.listBackground)
        .alert(.unknownError, isPresented: self.$isShowingErrorAlert)
        .onAppear {
            self.update(with: self.content)
        }
    }
}

extension ContentForm {
    var values: ContentFormValues {
        .init(
            type: self.type,
            link: self.link,
            title: self.title,
            theme: self.theme
        )
    }
    
    func save() {
        do {
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
            self.link = content.url.absoluteString
            self.title = content.title
            self.theme = content.theme
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
