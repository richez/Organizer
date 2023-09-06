//
//  ProjectCreatorView.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 06/09/2023.
//

import UIKit

protocol ProjectCreatorViewDelegate: AnyObject {
    func didTapSaveButton()
}

final class ProjectCreatorView: UIView {
    // MARK: - Properties

    private let viewRepresentation = ProjectCreatorViewRepresentation()
    weak var delegate: ProjectCreatorViewDelegate?

    private let fieldsView: ProjectCreatorFieldsView = .init()
    private let saveButton: FloatingActionButton = .init()

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Configuration

    func configure(with fieldsDescription: ProjectCreatorFieldsDescription) {
        self.fieldsView.configure(with: fieldsDescription)
    }
}

private extension ProjectCreatorView {
    // MARK: - Setup

    func setup() {
        self.backgroundColor = self.viewRepresentation.backgroundColor
        self.setupFieldsView()
        self.setupSaveButton()
    }

    func setupFieldsView() {
        self.addSubview(self.fieldsView)
        self.fieldsView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.fieldsView.topAnchor.constraint(equalTo: self.topAnchor),
            self.fieldsView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.fieldsView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }

    func setupSaveButton() {
        self.saveButton.setup(with: self.viewRepresentation.saveButtonViewRepresentation)

        self.saveButton.addAction(UIAction(handler: { [weak self] _ in
            self?.delegate?.didTapSaveButton()
        }), for: .touchUpInside)

        self.addSubview(self.saveButton)
        self.saveButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.saveButton.topAnchor.constraint(
                greaterThanOrEqualTo: self.fieldsView.bottomAnchor, constant: 8
            ),
            self.saveButton.bottomAnchor.constraint(
                equalTo: self.keyboardLayoutGuide.topAnchor, constant: -8, priority: .defaultLow
            ),
            self.saveButton.trailingAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20
            )
        ])
    }
}
