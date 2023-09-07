//
//  ProjectCell.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 05/09/2023.
//

import UIKit

final class ProjectCell: UITableViewCell {
    // MARK: - Properties

    private let viewRepresentation = ProjectCellViewRepresentation()

    private let titleLabel: UILabel = .init()

    // MARK: - Initialization

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        self.setup()
    }

    // MARK: - Configuration

    func configure(with description: ProjectCellDescription) {
        self.titleLabel.text = description.title
    }
}

private extension ProjectCell {
    // MARK: - Setup

    func setup() {
        self.backgroundColor = self.viewRepresentation.backgroundColor
        self.setupSelectedBackgroundView()
        self.setTitleView()
    }

    func setupSelectedBackgroundView() {
        let selectedBackgroundView = UIView()
        selectedBackgroundView.backgroundColor = self.viewRepresentation.selectedBackgroundColor
        self.selectedBackgroundView = selectedBackgroundView
    }

    func setTitleView() {
        self.titleLabel.textColor = self.viewRepresentation.titleColor

        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.titleLabel)
        NSLayoutConstraint.activate([
            self.titleLabel.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor),
            self.titleLabel.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor),
            self.titleLabel.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor)
        ])
    }
}
