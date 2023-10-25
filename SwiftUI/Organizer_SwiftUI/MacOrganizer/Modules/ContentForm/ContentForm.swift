//
//  ContentForm.swift
//  MacOrganizer
//
//  Created by Thibaut Richez on 19/10/2023.
//

import SwiftUI

struct ContentForm: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @State private var viewModel: ViewModel

    init(project: Project, content: ProjectContent? = nil) {
        self._viewModel = State(initialValue: ViewModel(project: project, content: content))
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            FormSaveButton {
                self.save()
            }

            Form {
                Picker("Type", selection: self.$viewModel.type) {
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
                    text: self.$viewModel.link,
                    isInvalid: self.$viewModel.isInvalidLink
                )

                FormTextField(
                    configuration: .contentTitle,
                    text: self.$viewModel.title,
                    isInvalid: self.$viewModel.isInvalidTitle
                )

                FormTextField(
                    configuration: .contentTheme,
                    text: self.$viewModel.theme,
                    isInvalid: self.$viewModel.isInvalidTheme
                )
            }
            .foregroundStyle(.white)
        }
        .padding()
        .frame(minWidth: 400, maxWidth: 400, minHeight: 250, maxHeight: 250)
        .background(.listBackground)
        .alert(.unknownError, isPresented: self.$viewModel.hasUnknownError)
        .onAppear {
            self.viewModel.update()
        }
    }
}

extension ContentForm {
    func save() {
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
