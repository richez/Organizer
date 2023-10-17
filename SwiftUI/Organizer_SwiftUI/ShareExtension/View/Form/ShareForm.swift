//
//  ShareForm.swift
//  ShareExtension
//
//  Created by Thibaut Richez on 17/10/2023.
//

import SwiftData
import SwiftUI

struct ShareForm: View {
    let content: ShareContent
    let finishAction: () -> Void

    private let viewModel = ViewModel()

    @State private var projectTitle: String = ""
    @State private var isInvalidProjectTitle: Bool = false
    @State private var selectedProject: Project?
    @State private var type: ProjectContentType = .article
    @State private var link: String = ""
    @State private var title: String = ""
    @State private var theme: String = ""
    @State private var isInvalidLink: Bool = false
    @State private var isInvalidTitle: Bool = false
    @State private var isInvalidTheme: Bool = false

    @FocusState private var focusedField: FormTextField.Name?

    var body: some View {
        ZStack(alignment: .bottom) {
            Form {
                FormSection("Project") {
                    ProjectPicker(
                        title: self.$projectTitle,
                        isInvalid: self.$isInvalidProjectTitle,
                        selectedProject: self.$selectedProject,
                        focusedField: self.$focusedField
                    )
                }
                
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
                }
                
                FormSection("Themes") {
                    FormTextField(
                        configuration: .contentLink,
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

            }
        }
        .padding(.top)
        .padding(.bottom, 30)
        .background(Color.listBackground)
        .scrollContentBackground(.hidden)
        .onAppear {
            self.update(with: self.content)
        }
    }
}

private extension ShareForm {
    func update(with content: ShareContent) {
        self.title = content.title
        self.link = content.url
    }
}
