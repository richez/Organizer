//
//  ShareFormViewModel.swift
//  ShareExtension
//
//  Created by Thibaut Richez on 21/09/2023.
//

import Foundation

struct ShareFormViewModel {
}

// MARK: - Public

extension ShareFormViewModel {
    var viewConfiguration: ShareFormViewConfiguration {
        .init(
            project: ShareFormMenu(
                text: "Project",
                placeholder: "My project",
                singleSelection: true,
                items: [.new(title: "New"), .custom(title: "Auto-Construction", id: UUID()), .custom(title: "Recherche emploi", id: UUID())]
            ),
            content: ContentFormViewConfiguration(
                saveButtonImageName: "checkmark",
                fields: ContentFormFieldsConfiguration(
                    type: ContentFormMenu(
                        text: "Type",
                        singleSelection: true,
                        items: ProjectContentType.allCases.map(\.rawValue),
                        selectedItem: ProjectContentType.article.rawValue
                    ),
                    name: ContentFormField(
                        text: "Name", placeholder: "My content", value: ""
                    ),
                    theme: ContentFormField(
                        text: "Themes", placeholder: "Isolation, tennis, recherche", value: ""
                    ),
                    link: ContentFormField(
                        text: "Link", placeholder: "https://www.youtube.com", value: ""
                    )
                )
            )
        )
    }

    func isFieldsValid(selectedProject: ProjectSelectedItem?,
                       type: String,
                       name: String,
                       theme: String,
                       link: String) -> Bool {
        let isValidSelectedProject = self.isSelectedProjectValid(selectedProject)
        let isValidType = ProjectContentType(rawValue: type) != nil
        let isValidName = !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        let isValidTheme = true
        let isValidLink = !link.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        return isValidSelectedProject && isValidType && isValidName && isValidTheme && isValidLink
    }

    func shouldHideProjectTextField(for selectedProject: ProjectSelectedItem?) -> Bool {
        switch selectedProject {
        case .new, .none:
            return false
        case .custom:
            return true
        }
    }
}

// MARK: - Helpers

private extension ShareFormViewModel {
    // MARK: Field Validation

    func isSelectedProjectValid(_ selectedProject: ProjectSelectedItem?) -> Bool {
        switch selectedProject {
        case .new(let projectName):
            return !projectName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        case .custom:
            return true
        case .none:
            return false
        }
    }
}
