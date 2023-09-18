//
//  NavbarTitleView.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 18/09/2023.
//

import UIKit

final class NavbarTitleView: UIView {
    // MARK: - Properties

    private let viewRepresentation: NavbarTitleViewRepresentation = .init()

    private let titleLabel: UILabel = .init()

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Configuration

    func configure(with title: String) {
        self.titleLabel.text = title
    }
}

private extension NavbarTitleView {
    func setup() {
        self.titleLabel.numberOfLines = self.viewRepresentation.numberOfLines
        self.titleLabel.textAlignment = self.viewRepresentation.textAlignment
        self.titleLabel.font = self.viewRepresentation.font
        self.titleLabel.textColor = self.viewRepresentation.textColor

        self.addSubview(self.titleLabel)
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.titleLabel.topAnchor.constraint(equalTo: self.topAnchor),
            self.titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
