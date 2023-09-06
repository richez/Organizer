//
//  FloatingActionButton.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 06/09/2023.
//

import UIKit
import Combine

final class FloatingActionButton: UIButton {
    // MARK: - Properties

    var subscriptions = Set<AnyCancellable>()

    func setup(with viewRepresentation: FloatingActionButtonViewRepresentation) {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = viewRepresentation.size / 2
        self.backgroundColor = viewRepresentation.backgroundColor
        self.tintColor = viewRepresentation.tintColor
        self.setImage(viewRepresentation.image, for: .normal)

        self
            .publisher(for: \.isHighlighted)
            .sink { isHighlighted in
                self.backgroundColor = isHighlighted ? viewRepresentation.highlightedBackgroundColor : viewRepresentation.backgroundColor
            }
            .store(in: &self.subscriptions)

        self
            .publisher(for: \.isSelected)
            .sink { isSelected in
                self.backgroundColor = isSelected ? viewRepresentation.selectedBackgroundColor : viewRepresentation.backgroundColor
            }
            .store(in: &self.subscriptions)

        self
            .publisher(for: \.isEnabled)
            .sink { isEnabled in
                self.backgroundColor = isEnabled ? viewRepresentation.backgroundColor : viewRepresentation.disabledBackgroundColor
            }
            .store(in: &self.subscriptions)

        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalToConstant: viewRepresentation.size),
            self.heightAnchor.constraint(equalToConstant: viewRepresentation.size)
        ])
    }
}
