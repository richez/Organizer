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

    private let viewRepresentation: FloatingActionButtonViewRepresentation
    var subscriptions = Set<AnyCancellable>()


    // MARK: - Initialization

    init(frame: CGRect = .zero, viewRepresentation: FloatingActionButtonViewRepresentation) {
        self.viewRepresentation = viewRepresentation
        super.init(frame: frame)

        self.setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension FloatingActionButton {
    // MARK: - Setup

    func setup() {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = self.viewRepresentation.size / 2
        self.backgroundColor = self.viewRepresentation.backgroundColor
        self.tintColor = self.viewRepresentation.tintColor
        self.setImage(self.viewRepresentation.image, for: .normal)

        self.setupStatesPublisher()

        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalToConstant: self.viewRepresentation.size),
            self.heightAnchor.constraint(equalToConstant: self.viewRepresentation.size)
        ])
    }

    func setupStatesPublisher() {
        self
            .publisher(for: \.isHighlighted)
            .sink { isHighlighted in
                self.backgroundColor = isHighlighted ? self.viewRepresentation.highlightedBackgroundColor : self.viewRepresentation.backgroundColor
            }
            .store(in: &self.subscriptions)

        self
            .publisher(for: \.isSelected)
            .sink { isSelected in
                self.backgroundColor = isSelected ? self.viewRepresentation.selectedBackgroundColor : self.viewRepresentation.backgroundColor
            }
            .store(in: &self.subscriptions)
    }
}
