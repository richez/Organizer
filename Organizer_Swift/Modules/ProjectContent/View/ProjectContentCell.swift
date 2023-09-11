//
//  ProjectContentCell.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 12/09/2023.
//

import UIKit

final class ProjectContentCell: UITableViewCell {
    // MARK: - Properties

    private let viewRepresentation = ProjectContentCellViewRepresentation()

    private let titleLabel: UILabel = .init()
    // TODO: add typeImageView (video, link, blog), theme

    // MARK: - Initialization

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        self.setup()
    }
}

private extension ProjectContentCell {
    // MARK: - Setup

    func setup() {
        self.backgroundColor = self.viewRepresentation.backgroundColor

        self.setupTitleLabel()
    }

    func setupTitleLabel() {
        self.titleLabel.textColor = self.viewRepresentation.titleColor
        self.titleLabel.font = self.viewRepresentation.titleFont

        self.addSubview(self.titleLabel)
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.titleLabel.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor),
            self.titleLabel.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor, constant: 5),
            self.titleLabel.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor, constant: -5),
        ])
    }
}
