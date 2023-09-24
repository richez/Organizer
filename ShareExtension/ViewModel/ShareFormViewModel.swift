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

    func shouldHideProjectTextField(for selectedProject: ProjectSelectedItem?) -> Bool {
        switch selectedProject {
        case .new, .none:
            return false
        case .custom:
            return true
        }
    }
}
