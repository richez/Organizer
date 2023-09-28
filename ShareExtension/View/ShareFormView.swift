//
//  ShareFormView.swift
//  ShareExtension
//
//  Created by Thibaut Richez on 21/09/2023.
//

import UIKit

protocol ShareFormViewDelegate: AnyObject {
    func didTapOnView()
    func didEditFields(selectedProject: ProjectSelectedItem?, type: String, link: String, name: String, theme: String)
    func didChangeProjectSelection(to selectedProject: ProjectSelectedItem?)
    func didEndEditingLink(_ link: String)
    func didTapSaveButton(selectedProject: ProjectSelectedItem?, type: String, link: String, name: String, theme: String)
}

final class ShareFormView: UIView {
    // MARK: - Properties

    private let viewRepresentation: ShareFormViewRepresentation = .init()

    weak var delegate: ShareFormViewDelegate?

    private let projectStackView: UIStackView = .init()
    private let errorLabel: UILabel = .init()
    private let projectLabel: UILabel = .init()
    private let projectButton: UIButton = .init()
    private let projectTextField: UITextField = .init()
    private let contentFormView: ContentFormView = .init()

    private var selectedProject: ProjectSelectedItem?

    var isProjectTextFieldHidden: Bool = false {
        didSet {
            self.projectTextField.isHidden = self.isProjectTextFieldHidden
        }
    }

    var isSaveButtonEnabled: Bool = false {
        didSet {
            self.contentFormView.isSaveButtonEnabled = self.isSaveButtonEnabled
        }
    }

    var isLinkErrorLabelHidden: Bool = true {
        didSet {
            self.contentFormView.fieldsView.isLinkErrorLabelHidden = self.isLinkErrorLabelHidden
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

    func configure(with configuration: ShareFormViewConfiguration?) {
        guard let configuration else { return }

        self.set(error: configuration.error)
        self.projectLabel.text = configuration.project.text
        self.projectTextField.placeholder = configuration.project.placeholder
        self.projectButton.menu = UIMenu(configuration: self.menuConfiguration(for: configuration.project))

        self.contentFormView.configure(with: configuration.content)
    }

    // MARK: - Setter

    func set(error: ShareFormError) {
        self.errorLabel.isHidden = error.isHidden
        self.errorLabel.text = error.text
    }

    // MARK: - Loader

    func startLoader() {
        self.isUserInteractionEnabled = false
        self.contentFormView.startLoader()
    }

    func stopLoader() {
        self.isUserInteractionEnabled = true
        self.contentFormView.stopLoader()
    }
}

private extension ShareFormView {

    // MARK: - Setup

    func setup() {
        self.backgroundColor = .background

        self.contentFormView.delegate = self

        self.setupProjectStackView()
        self.setupErrorLabel()
        self.setupProjectLabel()
        self.setupProjectButton()
        self.setupProjectTextField()
        self.setupContentFormView()
    }

    func setupProjectStackView() {
        self.projectStackView.setup(with: self.viewRepresentation.stackViewRepresentation)

        self.projectStackView.addArrangedSubview(self.errorLabel)
        self.projectStackView.addArrangedSubview(self.projectLabel)
        self.projectStackView.addArrangedSubview(self.projectButton)
        self.projectStackView.addArrangedSubview(self.projectTextField)

        self.addSubview(self.projectStackView)
        self.projectStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.projectStackView.topAnchor.constraint(equalTo: self.topAnchor),
            self.projectStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.projectStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }

    func setupErrorLabel() {
        self.errorLabel.isHidden = true
        self.errorLabel.textColor = self.viewRepresentation.errorLabelTextColor
        self.errorLabel.font = self.viewRepresentation.errorLabelFont
        self.errorLabel.textAlignment = self.viewRepresentation.errorTextAlignment

        self.errorLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.errorLabel.heightAnchor.constraint(equalToConstant: self.viewRepresentation.errorLabelHeight),
            self.errorLabel.leadingAnchor.constraint(equalTo: self.projectStackView.layoutMarginsGuide.leadingAnchor),
            self.errorLabel.trailingAnchor.constraint(equalTo: self.projectStackView.layoutMarginsGuide.trailingAnchor)
        ])
    }

    func setupProjectLabel() {
        self.projectLabel.textColor = self.viewRepresentation.projectLabelTextColor
        self.projectLabel.font = self.viewRepresentation.projectLabelFont

        self.projectLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.projectLabel.heightAnchor.constraint(equalToConstant: self.viewRepresentation.projectLabelHeight),
            self.projectLabel.leadingAnchor.constraint(equalTo: self.projectStackView.layoutMarginsGuide.leadingAnchor),
            self.projectLabel.trailingAnchor.constraint(equalTo: self.projectStackView.layoutMarginsGuide.trailingAnchor)
        ])
    }

    func setupProjectButton() {
        self.projectButton.showsMenuAsPrimaryAction = true
        self.projectButton.changesSelectionAsPrimaryAction = true
        self.projectButton.contentHorizontalAlignment = .leading
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = self.viewRepresentation.projectButtonBackgroundColor
        self.projectButton.configuration = config
        self.projectButton.setTitleColor(self.viewRepresentation.projectButtonTitleColor, for: .normal)

        self.projectButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.projectButton.heightAnchor.constraint(equalToConstant: self.viewRepresentation.projectButtonHeight),
            self.projectButton.leadingAnchor.constraint(equalTo: self.projectStackView.layoutMarginsGuide.leadingAnchor),
            self.projectButton.trailingAnchor.constraint(equalTo: self.projectStackView.layoutMarginsGuide.trailingAnchor)
        ])
    }

    func setupProjectTextField() {
        self.projectTextField.font = self.viewRepresentation.projectTextFieldFont
        self.projectTextField.borderStyle = self.viewRepresentation.projectTextFieldBorderStyle
        self.projectTextField.apply(rules: self.viewRepresentation.projectTextFieldRules)

        self.projectTextField.addAction(UIAction(handler: { [weak self] _ in
            guard let self = self else { return }
            self.selectedProject = .new(self.projectTextField.text ?? "")
            self.delegate?.didEditFields(
                selectedProject: self.selectedProject,
                type: self.contentFormView.fieldsView.typeButtonValue,
                link: self.contentFormView.fieldsView.linkTextFieldValue,
                name: self.contentFormView.fieldsView.nameTextFieldValue,
                theme: self.contentFormView.fieldsView.themeTextFieldValue
            )
        }), for: .editingChanged)

        self.projectTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.projectTextField.heightAnchor.constraint(equalToConstant: self.viewRepresentation.projectTextFieldHeight),
            self.projectTextField.leadingAnchor.constraint(equalTo: self.projectStackView.layoutMarginsGuide.leadingAnchor),
            self.projectTextField.trailingAnchor.constraint(equalTo: self.projectStackView.layoutMarginsGuide.trailingAnchor)
        ])
    }

    func setupContentFormView() {
        self.addSubview(self.contentFormView)
        self.contentFormView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.contentFormView.topAnchor.constraint(equalTo: self.projectStackView.bottomAnchor),
            self.contentFormView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.contentFormView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.contentFormView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }

    // MARK: - Menu

    func menuConfiguration(for menu: ShareFormMenu) -> MenuConfiguration {
        .init(
            singleSelection: menu.singleSelection,
            items: menu.items.map { item in
                return MenuItemConfiguration(title: item.title, isOn: item.isOn) { [weak self] in
                    guard let self = self else { return }
                    switch item {
                    case .new:
                        self.selectedProject = .new(self.projectTextField.text ?? "")
                    case .custom(_, let id):
                        self.selectedProject = .custom(id)
                    }

                    self.delegate?.didChangeProjectSelection(to: self.selectedProject)

                    self.delegate?.didEditFields(
                        selectedProject: self.selectedProject,
                        type: self.contentFormView.fieldsView.typeButtonValue,
                        link: self.contentFormView.fieldsView.linkTextFieldValue,
                        name: self.contentFormView.fieldsView.nameTextFieldValue,
                        theme: self.contentFormView.fieldsView.themeTextFieldValue
                    )
                }
            }
        )
    }
}

// MARK: - ContentFormViewDelegate

extension ShareFormView: ContentFormViewDelegate {
    func didTapOnView() {
        self.delegate?.didTapOnView()
    }

    func didEditFields(type: String, link: String, name: String, theme: String) {
        self.delegate?.didEditFields(selectedProject: self.selectedProject, type: type, link: link, name: name, theme: theme)
    }

    func didEndEditingLink(_ link: String) {
        self.delegate?.didEndEditingLink(link)
    }

    func didTapNameGetterButton(link: String) {}

    func didTapSaveButton(type: String, link: String, name: String, theme: String) {
        self.delegate?.didTapSaveButton(selectedProject: self.selectedProject, type: type, link: link, name: name, theme: theme)
    }
}
