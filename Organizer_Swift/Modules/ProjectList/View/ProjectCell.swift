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
    private let themeLabel: UILabel = .init()
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

    // MARK: - Life Cycle

    override func prepareForReuse() {
        super.prepareForReuse()

        self.titleLabel.text = nil
        self.themeLabel.text = nil
        self.dateLabel.text = nil
    }

    // MARK: - Configuration

    func configure(with description: ProjectDescription) {
        self.titleLabel.text = description.title
        self.themeLabel.text = description.theme
        self.dateLabel.text = description.lastUpdatedDate
    }
}

private extension ProjectCell {
    // MARK: - Setup

    func setup() {
        self.backgroundColor = self.viewRepresentation.backgroundColor

        self.setupSelectedBackgroundView()
        self.setupTitleLabel()
        self.setupThemeLabel()
        self.setupDateLabel()
        self.setupSeparatorView()
    }

    func setupSelectedBackgroundView() {
        let selectedBackgroundView = UIView()
        selectedBackgroundView.backgroundColor = self.viewRepresentation.selectedBackgroundColor
        self.selectedBackgroundView = selectedBackgroundView
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
        ])
    }

    func setupThemeLabel() {
        self.themeLabel.textColor = self.viewRepresentation.themeColor
        self.themeLabel.font = self.viewRepresentation.themeFont

        self.addSubview(self.themeLabel)
        self.themeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.themeLabel.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            self.themeLabel.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor),
            self.themeLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 8)
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
                greaterThanOrEqualTo: self.themeLabel.bottomAnchor
            ),
            self.dateLabel.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor)
        ])
    }

    func setupSeparatorView() {
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
