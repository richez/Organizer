//
//  ShareFormView.swift
//  ShareExtension
//
//  Created by Thibaut Richez on 21/09/2023.
//

import UIKit

protocol ShareFormViewDelegate: AnyObject {
    func didEditFields(selectedProject: ProjectSelectedItem?, type: String, name: String, theme: String, link: String)
    func didTapOnView()
    func didTapSaveButton(selectedProject: ProjectSelectedItem?, type: String, name: String, theme: String, link: String)
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
    private let activityIndicatorView: UIActivityIndicatorView = .init()

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

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Configuration

    func configure(with configuration: ShareFormViewConfiguration) {
        self.stopActivityIndicator()
        self.showError(with: configuration.errorMessage)

        self.projectLabel.text = configuration.project.text
        self.projectTextField.placeholder = configuration.project.placeholder
        self.projectButton.menu = UIMenu(configuration: self.menuConfiguration(for: configuration.project))

        self.contentFormView.configure(with: configuration.content)
    }

    // MARK: - Error

    func showError(with message: String?) {
        self.errorLabel.isHidden = message == nil
        self.errorLabel.text = message
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
        self.setupActivityIndicator()
        self.startActivityIndicator()
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
                name: self.contentFormView.fieldsView.nameTextFieldValue,
                theme: self.contentFormView.fieldsView.themeTextFieldValue,
                link: self.contentFormView.fieldsView.linkTextFieldValue
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

    func setupActivityIndicator() {
        self.activityIndicatorView.hidesWhenStopped = true
        self.activityIndicatorView.color = self.viewRepresentation.activityIndicatorColor
        self.activityIndicatorView.style = self.viewRepresentation.activityIndicatorStyle

        self.addSubview(self.activityIndicatorView)
        self.activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.activityIndicatorView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.activityIndicatorView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -80)
        ])
    }

    // MARK: - Activity Indicator

    func startActivityIndicator() {
        self.isUserInteractionEnabled = false
        self.activityIndicatorView.startAnimating()
    }

    func stopActivityIndicator() {
        self.isUserInteractionEnabled = true
        self.activityIndicatorView.stopAnimating()
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

                    self.delegate?.didEditFields(
                        selectedProject: self.selectedProject,
                        type: self.contentFormView.fieldsView.typeButtonValue,
                        name: self.contentFormView.fieldsView.nameTextFieldValue,
                        theme: self.contentFormView.fieldsView.themeTextFieldValue,
                        link: self.contentFormView.fieldsView.linkTextFieldValue
                    )
                }
            }
        )
    }
}

// MARK: - ContentFormViewDelegate

extension ShareFormView: ContentFormViewDelegate {
    func didEditFields(type: String, name: String, theme: String, link: String) {
        self.delegate?.didEditFields(selectedProject: self.selectedProject, type: type, name: name, theme: theme, link: link)
    }
    
    func didTapOnView() {
        self.delegate?.didTapOnView()
    }
    
    func didTapSaveButton(type: String, name: String, theme: String, link: String) {
        self.delegate?.didTapSaveButton(selectedProject: self.selectedProject, type: type, name: name, theme: theme, link: link)
    }
}
