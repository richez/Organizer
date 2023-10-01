//
//  ProjectFormView.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 06/09/2023.
//

import UIKit

protocol ProjectFormViewDelegate: AnyObject {
    func didTapOnView()
    func didEditFields(with values: ProjectFormFieldValues)
    func didTapSaveButton(with values: ProjectFormFieldValues)
}

final class ProjectFormView: UIView {
    // MARK: - Properties

    private let viewRepresentation: ProjectFormViewRepresentation = .init()
    weak var delegate: ProjectFormViewDelegate?

    var isSaveButtonEnabled: Bool = false {
        didSet {
            self.saveButton.isEnabled = self.isSaveButtonEnabled
        }
    }

    // MARK: Views

    private let fieldsView: ProjectFormFieldsView = .init()
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

    func configure(with configuration: ProjectFormViewConfiguration) {
        self.saveButton.configure(
            with: self.viewRepresentation.saveButtonViewRepresentation(imageName: configuration.saveButtonImageName)
        )
        self.fieldsView.configure(with: configuration.fields)
    }
}

private extension ProjectFormView {
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

        self.saveButton.addAction(UIAction(handler: { [weak self] _ in
            guard let self = self else { return }
            self.delegate?.didTapSaveButton(with: self.fieldsView.fieldValues)
        }), for: .touchUpInside)

        self.addSubview(self.saveButton)
        self.saveButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.saveButton.topAnchor.constraint(greaterThanOrEqualTo: self.fieldsView.bottomAnchor, constant: 8),
            self.saveButton.bottomAnchor.constraint(
                equalTo: self.keyboardLayoutGuide.topAnchor, constant: -8, priority: .defaultLow
            ),
            self.saveButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
    }

    // MARK: - Action

    @objc
    func didTapOnView(sender: UIView) {
        self.delegate?.didTapOnView()
    }
}

// MARK: - ProjectFormFieldsViewDelegate

extension ProjectFormView: ProjectFormFieldsViewDelegate {
    func didEditFields(with values: ProjectFormFieldValues) {
        self.delegate?.didEditFields(with: values)
    }
}
