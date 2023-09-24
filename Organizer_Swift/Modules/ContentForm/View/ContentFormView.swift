//
//  ContentFormView.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 12/09/2023.
//

import UIKit

protocol ContentFormViewDelegate: AnyObject {
    func didEditFields(type: String, name: String, theme: String, link: String)
    func didTapOnView()
    func didTapSaveButton(type: String, name: String, theme: String, link: String)
}

final class ContentFormView: UIView {
    // MARK: - Properties

    private let viewRepresentation: ContentFormViewRepresentation = .init()

    weak var delegate: ContentFormViewDelegate?

    let fieldsView: ContentFormFieldsView = .init()
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

    func configure(with configuration: ContentFormViewConfiguration) {
        self.saveButton.configure(
            with: self.viewRepresentation.saveButtonViewRepresentation(imageName: configuration.saveButtonImageName)
        )
        self.fieldsView.configure(with: configuration.fields)
    }
}

private extension ContentFormView {
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

// MARK: - ContentFormFieldsViewDelegate

extension ContentFormView: ContentFormFieldsViewDelegate {
    func didEditFields(type: String, name: String, theme: String, link: String) {
        self.delegate?.didEditFields(type: type, name: name, theme: theme, link: link)
    }
}
