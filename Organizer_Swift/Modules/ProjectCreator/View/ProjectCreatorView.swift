//
//  ProjectCreatorView.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 06/09/2023.
//

import UIKit

protocol ProjectCreatorViewDelegate: AnyObject {
    func didEditFields(name: String, theme: String)
    func didTapOnView()
    func didTapSaveButton(name: String, theme: String)
}

final class ProjectCreatorView: UIView {
    // MARK: - Properties

    private let viewRepresentation = ProjectCreatorViewRepresentation()
    weak var delegate: ProjectCreatorViewDelegate?

    private let fieldsView: ProjectCreatorFieldsView = .init()
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

    func configure(with fieldsDescription: ProjectCreatorFieldsDescription) {
        self.fieldsView.configure(with: fieldsDescription)
    }
}

// MARK: - ProjectCreatorFieldsViewDelegate

extension ProjectCreatorView: ProjectCreatorFieldsViewDelegate {
    func didEditFields(name: String, theme: String) {
        self.delegate?.didEditFields(name: name, theme: theme)
    }
}


private extension ProjectCreatorView {
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
                name: self.fieldsView.nameTextFieldValue,
                theme: self.fieldsView.themeTextFieldValue
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
