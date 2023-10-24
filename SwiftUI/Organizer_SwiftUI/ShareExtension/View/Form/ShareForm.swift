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

    @Environment(\.modelContext) private var modelContext

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

    @State private var isShowingErrorAlert: Bool = false

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
            
            FloatingButton("Save content", systemName: "checkmark") {
                self.save()
            }
            .padding(.bottom, 50)
        }
        .scrollDismissesKeyboard(.interactively)
        .padding(.top)
        .background(Color.listBackground)
        .scrollContentBackground(.hidden)
        .alert(.unknownError, isPresented: self.$isShowingErrorAlert)
        .onAppear {
            self.update(with: self.content)
        }
    }
}

private extension ShareForm {
    var values: ContentFormValues {
        .init(
            type: self.type,
            link: self.link,
            title: self.title,
            theme: self.theme
        )
    }

    func update(with content: ShareContent) {
        self.title = content.title
        self.link = content.url
    }

    func save() {
        do {
            self.focusedField = nil
            let project: SelectedProject = switch self.selectedProject {
            case .none: .new(self.projectTitle)
            case .some(let project): .custom(project)
            }
            try self.viewModel.save(values, project: project, in: self.modelContext)
            self.finishAction()
        } catch FormFieldValidator.Error.invalidFields(let fields) {
            self.isInvalidLink = fields.contains(.link)
            self.isInvalidTitle = fields.contains(.title)
            self.isInvalidTheme = fields.contains(.theme)
            self.isInvalidProjectTitle = fields.contains(.projectPicker)
        } catch {
            self.isShowingErrorAlert = true
        }
    }
}

extension ShareForm {
    enum SelectedProject: Hashable, Identifiable {
        case new(String)
        case custom(Project)

        var id: SelectedProject { self }
    }
}
