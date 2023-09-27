//
//  ContentFormFieldsView.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 12/09/2023.
//

import UIKit

protocol ContentFormFieldsViewDelegate: AnyObject {
    func didEditFields(type: String, link: String, name: String, theme: String)
    func didTapNameGetterButton(link: String)
}

final class ContentFormFieldsView: UIView {
    // MARK: - Properties

    private let viewRepresentation: ContentFormFieldsViewRepresentation = .init()

    private let formStackView: UIStackView = .init()

    private let typeLabel: UILabel = .init()
    private let typeButton: UIButton = .init()
    private let linkLabel: UILabel = .init()
    private let linkTextField: UITextField = .init()
    private let nameLabel: UILabel = .init()
    private let nameTextField: UITextField = .init()
    private let nameGetterButton: UIButton = .init()
    private let themeLabel: UILabel = .init()
    private let themeTextField: UITextField = .init()

    var typeButtonValue: String { self.typeButton.menu?.selectedElements.first?.title ?? "" }
    var linkTextFieldValue: String { self.linkTextField.text ?? "" }
    var nameTextFieldValue: String { self.nameTextField.text ?? "" }
    var themeTextFieldValue: String { self.themeTextField.text ?? "" }

    var isNameGetterButtonEnabled: Bool = false {
        didSet {
            self.nameGetterButton.isEnabled = self.isNameGetterButtonEnabled
        }
    }

    weak var delegate: ContentFormFieldsViewDelegate?

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Configuration

    func configure(with configuration: ContentFormFieldsConfiguration) {
        self.typeLabel.text = configuration.type.text
        self.typeButton.menu = UIMenu(configuration: self.menuConfiguration(for: configuration.type))

        self.linkLabel.text = configuration.link.text
        self.linkTextField.placeholder = configuration.link.placeholder
        self.linkTextField.text = configuration.link.value
        self.linkTextField.tag = configuration.link.tag

        self.nameLabel.text = configuration.name.text
        self.nameTextField.placeholder = configuration.name.placeholder
        self.nameTextField.text = configuration.name.value
        self.nameTextField.tag = configuration.name.tag

        self.nameGetterButton.setTitle(configuration.nameGetter.text, for: .normal)
        self.nameGetterButton.isHidden = configuration.nameGetter.isHidden

        self.themeLabel.text = configuration.theme.text
        self.themeTextField.placeholder = configuration.theme.placeholder
        self.themeTextField.text = configuration.theme.value
        self.themeTextField.tag = configuration.theme.tag
    }

    // MARK: - Setter

    func set(name: String) {
        self.nameTextField.text = name
        self.delegate?.didEditFields(
            type: self.typeButtonValue,
            link: self.linkTextFieldValue,
            name: self.nameTextFieldValue,
            theme: self.themeTextFieldValue
        )
    }
}

private extension ContentFormFieldsView {
    // MARK: - Setup

    func setup() {
        self.setupFormStackView()
        self.setupLabel(self.typeLabel)
        self.setupTypeButton()
        self.setupLabel(self.linkLabel)
        self.setupTextField(self.linkTextField, rules: self.viewRepresentation.linkTextFieldRules)
        self.setupLabel(self.nameLabel)
        self.setupTextField(self.nameTextField, rules: self.viewRepresentation.nameTextFieldRules)
        self.setupNameGetterButton()
        self.setupLabel(self.themeLabel)
        self.setupTextField(self.themeTextField, rules: self.viewRepresentation.themeTextFieldRules)
    }

    func setupFormStackView() {
        self.formStackView.setup(with: self.viewRepresentation.stackViewRepresentation)

        self.formStackView.addArrangedSubview(self.typeLabel)
        self.formStackView.addArrangedSubview(self.typeButton)
        self.formStackView.addArrangedSubview(self.linkLabel)
        self.formStackView.addArrangedSubview(self.linkTextField)
        self.formStackView.addArrangedSubview(self.nameLabel)
        self.formStackView.addArrangedSubview(self.nameTextField)
        self.formStackView.addArrangedSubview(self.nameGetterButton)
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

    func setupTypeButton() {
        self.typeButton.showsMenuAsPrimaryAction = true
        self.typeButton.changesSelectionAsPrimaryAction = true
        self.typeButton.contentHorizontalAlignment = .leading
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = self.viewRepresentation.typeButtonBackgroundColor
        self.typeButton.configuration = config
        self.typeButton.setTitleColor(self.viewRepresentation.typeButtonTitleColor, for: .normal)

        self.typeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.typeButton.heightAnchor.constraint(equalToConstant: self.viewRepresentation.typeButtonHeight),
            self.typeButton.leadingAnchor.constraint(equalTo: self.formStackView.layoutMarginsGuide.leadingAnchor),
            self.typeButton.trailingAnchor.constraint(
                equalTo: self.formStackView.layoutMarginsGuide.trailingAnchor
            )
        ])
    }

    func setupLabel(_ label: UILabel) {
        label.textColor = self.viewRepresentation.labelsTextColor
        label.font = self.viewRepresentation.labelsFont

        label.translatesAutoresizingMaskIntoConstraints = false
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

        textField.addAction(UIAction(handler: { [weak self] _ in
            guard let self = self else { return }
            self.delegate?.didEditFields(
                type: self.typeButtonValue,
                link: self.linkTextFieldValue,
                name: self.nameTextFieldValue,
                theme: self.themeTextFieldValue
            )
        }), for: .editingChanged)

        textField.addAction(UIAction(handler: { [weak textField] action in
            if textField?.returnKeyType == .next {
                textField?.next()
            }
        }), for: .editingDidEndOnExit)

        textField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textField.heightAnchor.constraint(equalToConstant: self.viewRepresentation.textFieldsHeight),
            textField.leadingAnchor.constraint(equalTo: self.formStackView.layoutMarginsGuide.leadingAnchor),
            textField.trailingAnchor.constraint(
                equalTo: self.formStackView.layoutMarginsGuide.trailingAnchor
            )
        ])
    }

    func setupNameGetterButton() {
        self.nameGetterButton.isEnabled = self.isNameGetterButtonEnabled
        self.nameGetterButton.layer.borderWidth = 0
        self.nameGetterButton.contentHorizontalAlignment = .leading
        self.nameGetterButton.titleLabel?.font = self.viewRepresentation.nameGetterFont
        self.nameGetterButton.setTitleColor(.link, for: .normal)
        self.nameGetterButton.setTitleColor(.link.withAlphaComponent(0.5), for: .disabled)
        self.nameGetterButton.setTitleColor(.link.withAlphaComponent(0.5), for: .highlighted)

        self.nameGetterButton.addAction(UIAction(handler: { [weak self] _ in
            guard let self = self else { return }
            self.delegate?.didTapNameGetterButton(link: self.linkTextFieldValue)
        }), for: .touchUpInside)

        self.nameGetterButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.nameGetterButton.heightAnchor.constraint(equalToConstant: self.viewRepresentation.nameGetterButtonHeight),
            self.nameGetterButton.leadingAnchor.constraint(equalTo: self.formStackView.layoutMarginsGuide.leadingAnchor),
            self.nameGetterButton.trailingAnchor.constraint(
                equalTo: self.formStackView.layoutMarginsGuide.trailingAnchor
            )
        ])

    }

    // MARK: - Menu

    func menuConfiguration(for menu: ContentFormMenu) -> MenuConfiguration {
        .init(
            singleSelection: menu.singleSelection,
            items: menu.items.map { item in
                MenuItemConfiguration(title: item, isOn: item == menu.selectedItem) { [weak self] in
                    guard let self = self else { return }
                    self.delegate?.didEditFields(
                        type: self.typeButtonValue,
                        link: self.linkTextFieldValue,
                        name: self.nameTextFieldValue,
                        theme: self.themeTextFieldValue
                    )
                }
            }
        )
    }
}
