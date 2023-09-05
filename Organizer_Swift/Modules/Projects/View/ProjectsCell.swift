//
//  ProjectsCell.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 05/09/2023.
//

import UIKit

final class ProjectsCell: UITableViewCell {
    // MARK: - Properties

    private let cellRepresentation = ProjectsCellRepresentation()

    private let titleLabel = UILabel()

    // MARK: - Initialization

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        self.setup()
    }

    func configure(with project: ProjectCellData) {
        self.titleLabel.text = project.title
    }
}

private extension ProjectsCell {
    // MARK: - Setup

    func setup() {
        self.backgroundColor = self.cellRepresentation.backgroundColor

        self.titleLabel.textColor = self.cellRepresentation.titleColor

        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.titleLabel)
        NSLayoutConstraint.activate([
            self.titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.titleLabel.topAnchor.constraint(equalTo: self.topAnchor),
            self.titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
