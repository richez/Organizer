//
//  ShareForm.swift
//  ShareExtension
//
//  Created by Thibaut Richez on 17/10/2023.
//

import SwiftData
import SwiftUI

struct ShareForm: View {
    let finishAction: () -> Void

    @Environment(\.modelContext) private var modelContext
    @FocusState private var focusedField: FormTextField.Name?
    @State private var viewModel: ViewModel

    init(content: ShareContent, finishAction: @escaping () -> Void) {
        self._viewModel = State(initialValue: ViewModel(content: content))
        self.finishAction = finishAction
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            Form {
                FormSection("Project") {
                    ProjectPicker(
                        title: self.$viewModel.projectTitle,
                        isInvalid: self.$viewModel.isInvalidProjectTitle,
                        selectedProject: self.$viewModel.selectedProject,
                        focusedField: self.$focusedField
                    )
                }
                
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
                }
                
                FormSection("Themes") {
                    FormTextField(
                        configuration: .contentLink,
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
            .padding(.bottom, 50)
        }
        .scrollDismissesKeyboard(.interactively)
        .padding(.top)
        .background(Color.listBackground)
        .scrollContentBackground(.hidden)
        .alert(.unknownError, isPresented: self.$viewModel.hasUnknownError)
        .onAppear {
            self.viewModel.update()
        }
    }
}

private extension ShareForm {
    func save() {
        self.focusedField = nil
        self.viewModel.save(in: self.modelContext)
        if self.viewModel.didSaveContent {
            self.finishAction()
        }
    }
}
