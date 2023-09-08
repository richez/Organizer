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
    private let dateLabel: UILabel = .init()
    private let separatorView: UIView = .init()

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

    func configure(with description: ProjectDescription) {
        self.titleLabel.text = description.title
        self.dateLabel.text = description.lastUpdatedDate
    }
}

private extension ProjectCell {
    // MARK: - Setup

    func setup() {
        self.backgroundColor = self.viewRepresentation.backgroundColor
        self.setupSelectedBackgroundView()
        self.setTitleView()
        self.setupDateLabel()
        self.setupSeparator()
    }

    func setupSelectedBackgroundView() {
        let selectedBackgroundView = UIView()
        selectedBackgroundView.backgroundColor = self.viewRepresentation.selectedBackgroundColor
        self.selectedBackgroundView = selectedBackgroundView
    }

    func setTitleView() {
        self.titleLabel.textColor = self.viewRepresentation.titleColor
        self.titleLabel.font = self.viewRepresentation.titleFont

        self.addSubview(self.titleLabel)
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.titleLabel.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor),
            self.titleLabel.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor, constant: 5),
        ])
    }

    func setupDateLabel() {
        self.dateLabel.textColor = self.viewRepresentation.dateColor
        self.dateLabel.font = self.viewRepresentation.dateFont
        self.addSubview(self.dateLabel)
        self.dateLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.dateLabel.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            self.dateLabel.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor),
            self.dateLabel.topAnchor.constraint(
                greaterThanOrEqualTo: self.titleLabel.bottomAnchor
            ),
            self.dateLabel.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor)
        ])
    }

    func setupSeparator() {
        self.separatorView.backgroundColor = self.viewRepresentation.separatorColor

        self.addSubview(self.separatorView)
        self.separatorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.separatorView.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            self.separatorView.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor),
            self.separatorView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.separatorView.heightAnchor.constraint(
                equalToConstant: self.viewRepresentation.separatorHeight
            )
        ])
    }
}
