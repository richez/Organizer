//
//  ContentFormViewRepresentation.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 12/09/2023.
//

import UIKit

struct ContentFormViewRepresentation {
    var backgroundColor: UIColor = .background

    var activityIndicatorStyle: UIActivityIndicatorView.Style = .large
    var activityIndicatorColor: UIColor = .contentFormLoader

    func saveButtonViewRepresentation(imageName: String) -> FloatingActionButtonViewRepresentation {
        .init(
            size: 60,
            backgroundColor: .contentFormSaveButtonBackground,
            highlightedBackgroundColor: .contentFormSaveButtonBackground.withAlphaComponent(0.3),
            selectedBackgroundColor: .contentFormSaveButtonBackground.withAlphaComponent(0.3),
            disabledBackgroundColor: .contentFormSaveButtonBackground.withAlphaComponent(0.1),
            tintColor: .black,
            image: UIImage(
                systemName: imageName,
                withConfiguration: UIImage.SymbolConfiguration(scale: .large)
            )
        )
    }
}
