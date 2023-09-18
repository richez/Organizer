//
//  ProjectContentCreatorView.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 12/09/2023.
//

import Foundation

import UIKit

protocol ProjectContentCreatorViewDelegate: AnyObject {
    func didEditFields(type: String, name: String, theme: String, link: String)
    func didTapOnView()
    func didTapSaveButton(type: String, name: String, theme: String, link: String)
}

final class ProjectContentCreatorView: UIView {
    // MARK: - Properties

    private let viewRepresentation: ProjectContentCreatorViewRepresentation = .init()

    weak var delegate: ProjectContentCreatorViewDelegate?

    private let fieldsView: ProjectContentCreatorFieldsView = .init()
    private let saveButton: FloatingActionButton = .init()

    var isSaveButtonEnabled: Bool = false {
        didSet {
            self.saveButton.isEnabled = self.isSaveButtonEnabled
        }
    }

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Configuration

    func configure(with fieldsDescription: ProjectContentCreatorFieldsDescription) {
        self.fieldsView.configure(with: fieldsDescription)
    }
}

// MARK: - ProjectContentCreatorFieldsViewDelegate

extension ProjectContentCreatorView: ProjectContentCreatorFieldsViewDelegate {
    func didEditFields(type: String, name: String, theme: String, link: String) {
        self.delegate?.didEditFields(type: type, name: name, theme: theme, link: link)
    }
}


private extension ProjectContentCreatorView {
    // MARK: - Setup

    func setup() {
        self.backgroundColor = self.viewRepresentation.backgroundColor

        self.addGestureRecognizer(
            UITapGestureRecognizer(target: self, action: #selector(self.didTapOnView(sender:)))
        )

        self.setupFieldsView()
        self.setupSaveButton()
    }

    func setupFieldsView() {
        self.fieldsView.delegate = self

        self.addSubview(self.fieldsView)
        self.fieldsView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.fieldsView.topAnchor.constraint(equalTo: self.topAnchor),
            self.fieldsView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.fieldsView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }

    func setupSaveButton() {
        self.saveButton.isEnabled = self.isSaveButtonEnabled
        self.saveButton.setup(with: self.viewRepresentation.saveButtonViewRepresentation)

        self.saveButton.addAction(UIAction(handler: { [weak self] _ in
            guard let self = self else { return }
            self.delegate?.didTapSaveButton(
                type: self.fieldsView.typeButtonValue,
                name: self.fieldsView.nameTextFieldValue,
                theme: self.fieldsView.themeTextFieldValue,
                link: self.fieldsView.linkTextFieldValue
            )
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

    // MARK: - Tap Gesture Action

    @objc
    func didTapOnView(sender: UIView) {
        self.delegate?.didTapOnView()
    }
}
