//
//  ProjectFormFieldsView.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 06/09/2023.
//

import UIKit

@MainActor
protocol ProjectFormFieldsViewDelegate: AnyObject {
    func didEditFields(with values: ProjectFormFieldValues)
}

final class ProjectFormFieldsView: UIView {
    // MARK: - Properties

    private let viewRepresentation: ProjectFormFieldsViewRepresentation = .init()
    weak var delegate: ProjectFormFieldsViewDelegate?

    var fieldValues: ProjectFormFieldValues {
        .init(
            name: self.nameTextField.text ?? "",
            theme: self.themeTextField.text ?? ""
        )
    }

    // MARK: Views

    private let formStackView: UIStackView = .init()

    private let nameLabel: UILabel = .init()
    private let nameTextField: UITextField = .init()

    private let themeLabel: UILabel = .init()
    private let themeTextField: UITextField = .init()

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Configuration

    func configure(with configuration: ProjectFormFieldsConfiguration) {
        self.nameLabel.text = configuration.name.text
        self.nameTextField.placeholder = configuration.name.placeholder
        self.nameTextField.text = configuration.name.value
        self.nameTextField.tag = configuration.name.tag

        self.themeLabel.text = configuration.theme.text
        self.themeTextField.placeholder = configuration.theme.placeholder
        self.themeTextField.text = configuration.theme.value
        self.themeTextField.tag = configuration.theme.tag
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
        label.textColor = self.viewRepresentation.labelsTextColor
        label.font = self.viewRepresentation.labelsFont

        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.heightAnchor.constraint(equalToConstant: self.viewRepresentation.contentsHeight)
        ])
    }

    func setupTextField(_ textField: UITextField, rules: TextFieldRules) {
        textField.font = self.viewRepresentation.textFieldsFont
        textField.borderStyle = self.viewRepresentation.textFieldsBorderStyle
        textField.apply(rules: rules)

        textField.addAction(UIAction(handler: { [weak self] _ in
            guard let self else { return }
            self.delegate?.didEditFields(with: self.fieldValues)
        }), for: .editingChanged)

        textField.addAction(UIAction(handler: { [weak textField] action in
            if textField?.returnKeyType == .next {
                textField?.next()
            }
        }), for: .editingDidEndOnExit)

        textField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textField.heightAnchor.constraint(equalToConstant: self.viewRepresentation.contentsHeight),
            textField.widthAnchor.constraint(equalTo: self.formStackView.layoutMarginsGuide.widthAnchor)
        ])
    }
}
