//
//  ProjectContentCreatorFieldsView.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 12/09/2023.
//

import Combine
import UIKit

protocol ProjectContentCreatorFieldsViewDelegate: AnyObject {
    func didEditFields(name: String, theme: String, link: String)
}

final class ProjectContentCreatorFieldsView: UIView {
    // MARK: - Properties

    private let viewRepresentation = ProjectContentCreatorFieldsViewRepresentation()

    private let formStackView: UIStackView = .init()

    private let nameLabel: UILabel = .init()
    private let nameTextField: UITextField = .init()
    private let themeLabel: UILabel = .init()
    private let themeTextField: UITextField = .init()
    private let linkLabel: UILabel = .init()
    private let linkTextField: UITextField = .init()

    var nameTextFieldValue: String { self.nameTextField.text ?? "" }
    var themeTextFieldValue: String { self.themeTextField.text ?? "" }
    var linkTextFieldValue: String { self.linkTextField.text ?? "" }

    weak var delegate: ProjectContentCreatorFieldsViewDelegate?

    var subscriptions = Set<AnyCancellable>()

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
        self.nameLabel.text = fieldsDescription.name.text
        self.nameTextField.placeholder = fieldsDescription.name.placeholder

        self.themeLabel.text = fieldsDescription.theme.text
        self.themeTextField.placeholder = fieldsDescription.theme.placeholder

        self.linkLabel.text = fieldsDescription.link.text
        self.linkTextField.placeholder = fieldsDescription.link.placeholder
    }
}

private extension ProjectContentCreatorFieldsView {
    // MARK: - Setup

    func setup() {
        self.setupStackView()
        self.setupLabel(self.nameLabel)
        self.setupTextField(self.nameTextField)
        self.setupLabel(self.themeLabel)
        self.setupTextField(self.themeTextField)
        self.setupLabel(self.linkLabel)
        self.setupTextField(self.linkTextField)
    }

    func setupStackView() {
        self.formStackView.setup(with: self.viewRepresentation.stackViewRepresentation)

        self.formStackView.addArrangedSubview(self.nameLabel)
        self.formStackView.addArrangedSubview(self.nameTextField)
        self.formStackView.addArrangedSubview(self.themeLabel)
        self.formStackView.addArrangedSubview(self.themeTextField)
        self.formStackView.addArrangedSubview(self.linkLabel)
        self.formStackView.addArrangedSubview(self.linkTextField)

        self.addSubview(self.formStackView)
        self.formStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.formStackView.topAnchor.constraint(equalTo: self.topAnchor),
            self.formStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.formStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.formStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }

    func setupLabel(_ label: UILabel) {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = self.viewRepresentation.labelsTextColor
        label.font = self.viewRepresentation.labelsFont

        NSLayoutConstraint.activate([
            label.heightAnchor.constraint(equalToConstant: self.viewRepresentation.labelsHeight),
            label.leadingAnchor.constraint(equalTo: self.formStackView.layoutMarginsGuide.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: self.formStackView.layoutMarginsGuide.trailingAnchor)
        ])

    }

    func setupTextField(_ textField: UITextField) {
        textField.font = self.viewRepresentation.textFieldsFont
        textField.borderStyle = self.viewRepresentation.textFieldsBorderStyle
        textField.autocapitalizationType = .sentences
        textField.clearButtonMode = .always

        NotificationCenter.default
                .publisher(for: UITextField.textDidChangeNotification, object: textField)
                .sink { [weak self] text in
                    self?.delegate?.didEditFields(
                        name: self?.nameTextField.text ?? "",
                        theme: self?.themeTextField.text ?? "",
                        link: self?.linkTextField.text ?? ""
                    )
                }
                .store(in: &self.subscriptions)

        textField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textField.heightAnchor.constraint(equalToConstant: self.viewRepresentation.textFieldsHeight),
            textField.leadingAnchor.constraint(equalTo: self.formStackView.layoutMarginsGuide.leadingAnchor),
            textField.trailingAnchor.constraint(
                equalTo: self.formStackView.layoutMarginsGuide.trailingAnchor
            )
        ])
    }
}

