//
//  ContentFormViewRepresentation.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 12/09/2023.
//

import UIKit

/// Define the properties used to setup the ``ContentFormView``
struct ContentFormViewRepresentation {
    var backgroundColor: UIColor = .background

    var activityIndicatorStyle: UIActivityIndicatorView.Style = .large
    var activityIndicatorColor: UIColor = .contentFormLoader

    var saveButtonViewRepresentation = FloatingActionButtonViewRepresentation(
        size: 60,
        backgroundColor: .contentFormSaveButtonBackground,
        highlightedBackgroundColor: .contentFormSaveButtonBackground.withAlphaComponent(0.3),
        selectedBackgroundColor: .contentFormSaveButtonBackground.withAlphaComponent(0.3),
        disabledBackgroundColor: .contentFormSaveButtonBackground.withAlphaComponent(0.1),
        tintColor: .black
    )

    func saveButtonImage(named name: String) -> UIImage? {
        UIImage(
            systemName: name,
            withConfiguration: UIImage.SymbolConfiguration(scale: .large)
        )
    }
}
