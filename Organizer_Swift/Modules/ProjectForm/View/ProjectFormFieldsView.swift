//
//  ProjectFormFieldsView.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 06/09/2023.
//

import Combine
import UIKit

protocol ProjectFormFieldsViewDelegate: AnyObject {
    func didEditFields(name: String, theme: String)
}

final class ProjectFormFieldsView: UIView {
    // MARK: - Properties

    private let viewRepresentation: ProjectFormFieldsViewRepresentation = .init()

    private let formStackView: UIStackView = .init()

    private let nameLabel: UILabel = .init()
    private let nameTextField: UITextField = .init()
    private let themeLabel: UILabel = .init()
    private let themeTextField: UITextField = .init()

    var nameTextFieldValue: String { self.nameTextField.text ?? "" }
    var themeTextFieldValue: String { self.themeTextField.text ?? "" }

    weak var delegate: ProjectFormFieldsViewDelegate?

    var subscriptions: Set<AnyCancellable> = .init()

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Configuration

    func configure(with fieldsDescription: ProjectFormFieldsDescription) {
        self.nameLabel.text = fieldsDescription.name.text
        self.nameTextField.placeholder = fieldsDescription.name.placeholder
        self.nameTextField.text = fieldsDescription.name.value

        self.themeLabel.text = fieldsDescription.theme.text
        self.themeTextField.placeholder = fieldsDescription.theme.placeholder
        self.themeTextField.text = fieldsDescription.theme.value
    }
}

private extension ProjectFormFieldsView {
    // MARK: - Setup
    
    func setup() {
        self.setupStackView()
        self.setupLabel(self.nameLabel)
        self.setupTextField(self.nameTextField, rules: self.viewRepresentation.nameTextFieldRules)
        self.setupLabel(self.themeLabel)
        self.setupTextField(self.themeTextField, rules: self.viewRepresentation.themeTextFieldRules)
    }

    func setupStackView() {
        self.formStackView.setup(with: self.viewRepresentation.stackViewRepresentation)

        self.formStackView.addArrangedSubview(self.nameLabel)
        self.formStackView.addArrangedSubview(self.nameTextField)
        self.formStackView.addArrangedSubview(self.themeLabel)
        self.formStackView.addArrangedSubview(self.themeTextField)

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

    func setupTextField(_ textField: UITextField, rules: TextFieldRules) {
        textField.font = self.viewRepresentation.textFieldsFont
        textField.borderStyle = self.viewRepresentation.textFieldsBorderStyle
        textField.apply(rules: rules)

        NotificationCenter.default
                .publisher(for: UITextField.textDidChangeNotification, object: textField)
                .sink { [weak self] _ in
                    guard let self = self else { return }
                    self.delegate?.didEditFields(
                        name: self.nameTextFieldValue,
                        theme: self.themeTextFieldValue
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
