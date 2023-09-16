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

    private let typeImageView: UIImageView = .init()
    private let titleLabel: UILabel = .init()
    private let themeLabel: UILabel = .init()
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

        self.typeImageView.image = nil
        self.titleLabel.text = nil
        self.themeLabel.text = nil
    }

    // MARK: - Configuration

    func configure(with description: ProjectContentDescription) {
        self.typeImageView.image = self.viewRepresentation.typeImage(with: description.typeImageName)
        self.titleLabel.text = description.title
        self.themeLabel.text = description.theme
    }
}

private extension ProjectContentCell {
    // MARK: - Setup

    func setup() {
        self.backgroundColor = self.viewRepresentation.backgroundColor

        self.setupSelectedBackgroundView()
        self.setupTypeImageView()
        self.setupTitleLabel()
        self.setupThemeLabel()
        self.setupSeparatorView()
    }

    func setupSelectedBackgroundView() {
        let selectedBackgroundView = UIView()
        selectedBackgroundView.backgroundColor = self.viewRepresentation.selectedBackgroundColor
        self.selectedBackgroundView = selectedBackgroundView
    }

    func setupTypeImageView() {
        self.typeImageView.tintColor = self.viewRepresentation.typeImageTintColor

        self.addSubview(self.typeImageView)
        self.typeImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.typeImageView.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            self.typeImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.typeImageView.widthAnchor.constraint(
                equalToConstant: self.viewRepresentation.typeImageSize
            ),
            self.typeImageView.heightAnchor.constraint(
                equalToConstant: self.viewRepresentation.typeImageSize
            )
        ])
    }


    func setupTitleLabel() {
        self.titleLabel.textColor = self.viewRepresentation.titleColor
        self.titleLabel.font = self.viewRepresentation.titleFont

        self.addSubview(self.titleLabel)
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.titleLabel.leadingAnchor.constraint(
                equalTo: self.typeImageView.trailingAnchor,
                constant: 8
            ),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor),
            self.titleLabel.centerYAnchor.constraint(equalTo: self.typeImageView.centerYAnchor)
        ])
    }

    func setupThemeLabel() {
        self.themeLabel.textColor = self.viewRepresentation.themeColor
        self.themeLabel.font = self.viewRepresentation.themeFont

        self.addSubview(self.themeLabel)
        self.themeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.themeLabel.leadingAnchor.constraint(equalTo: self.titleLabel.leadingAnchor),
            self.themeLabel.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor),
            self.themeLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 8)
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
