//
//  ShareViewModel.swift
//  ShareExtension
//
//  Created by Thibaut Richez on 21/09/2023.
//

import Foundation

struct ShareViewModel {
}

// MARK: - Public

extension ShareViewModel {
    var viewConfiguration: ContentFormViewConfiguration {
        .init(
            saveButtonImageName: "checkmark",
            fields: ContentFormFieldsConfiguration(
                type: ContentFormMenu(
                    text: "Type",
                    singleSelection: true,
                    items: ProjectContentType.allCases.map(\.rawValue),
                    selectedItem: ProjectContentType.article.rawValue
                ),
                name: ContentFormField(
                    text: "Name", placeholder: "My project", value: ""
                ),
                theme: ContentFormField(
                    text: "Themes", placeholder: "Sport, Construction, Work", value: ""
                ),
                link: ContentFormField(
                    text: "Link", placeholder: "https://www.youtube.com", value: ""
                )
            )
        )
    }
}
