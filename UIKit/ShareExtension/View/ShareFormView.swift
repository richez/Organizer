//
//  ShareFormView.swift
//  ShareExtension
//
//  Created by Thibaut Richez on 21/09/2023.
//

import UIKit

@MainActor
protocol ShareFormViewDelegate: AnyObject {
    func didTapOnView()
    func didEditFields(with values: ShareFormFieldValues)
    func didChangeProjectSelection(to selectedProject: ProjectSelectedItem?)
    func didEndEditingLink(_ link: String)
    func didTapSaveButton(with values: ShareFormFieldValues)
}

final class ShareFormView: UIView {
    // MARK: - Properties

    private let viewRepresentation: ShareFormViewRepresentation = .init()
    weak var delegate: ShareFormViewDelegate?
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

    // MARK: Views

    private let projectStackView: UIStackView = .init()

    private let projectLabel: UILabel = .init()
    private let projectButton: UIButton = .init()
    private let projectTextField: UITextField = .init()

    private let contentFormView: ContentFormView = .init()

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

        self.projectLabel.text = configuration.project.text
        self.projectTextField.placeholder = configuration.project.placeholder
        self.projectButton.menu = UIMenu(configuration: self.menuConfiguration(for: configuration.project))

        self.contentFormView.configure(with: configuration.content)
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

        self.setupProjectLabel()
        self.setupProjectButton()
        self.setupProjectTextField()

        self.setupContentFormView()
    }

    func setupProjectStackView() {
        self.projectStackView.setup(with: self.viewRepresentation.stackViewRepresentation)

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

    func setupProjectLabel() {
        self.projectLabel.textColor = self.viewRepresentation.projectLabelTextColor
        self.projectLabel.font = self.viewRepresentation.projectLabelFont

        self.projectLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.projectLabel.heightAnchor.constraint(equalToConstant: self.viewRepresentation.contentsHeight)
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
            self.projectButton.heightAnchor.constraint(equalToConstant: self.viewRepresentation.contentsHeight),
            self.projectButton.widthAnchor.constraint(equalTo: self.projectStackView.layoutMarginsGuide.widthAnchor)
        ])
    }

    func setupProjectTextField() {
        self.projectTextField.font = self.viewRepresentation.projectTextFieldFont
        self.projectTextField.borderStyle = self.viewRepresentation.projectTextFieldBorderStyle
        self.projectTextField.apply(rules: self.viewRepresentation.projectTextFieldRules)

        self.projectTextField.addAction(UIAction(handler: { [weak self] _ in
            guard let self else { return }
            self.selectedProject = .new(self.projectTextField.text ?? "")
            self.delegate?.didEditFields(with: ShareFormFieldValues(
                selectedProject: self.selectedProject, content: self.contentFormView.fieldsView.fieldValues
            ))
        }), for: .editingChanged)

        self.projectTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.projectTextField.heightAnchor.constraint(equalToConstant: self.viewRepresentation.contentsHeight),
            self.projectTextField.widthAnchor.constraint(equalTo: self.projectStackView.layoutMarginsGuide.widthAnchor)
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
                    guard let self else { return }
                    switch item {
                    case .new:
                        self.selectedProject = .new(self.projectTextField.text ?? "")
                    case .custom(_, let id):
                        self.selectedProject = .custom(id)
                    }

                    self.delegate?.didChangeProjectSelection(to: self.selectedProject)

                    self.delegate?.didEditFields(with: ShareFormFieldValues(
                        selectedProject: self.selectedProject, content: self.contentFormView.fieldsView.fieldValues
                    ))
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

    func didEditFields(with values: ContentFormFieldValues) {
        self.delegate?.didEditFields(with: ShareFormFieldValues(
            selectedProject: self.selectedProject, content: values
        ))
    }

    func didEndEditingLink(_ link: String) {
        self.delegate?.didEndEditingLink(link)
    }

    func didTapNameGetterButton(link: String) {}

    func didTapSaveButton(with values: ContentFormFieldValues) {
        self.delegate?.didTapSaveButton(with: ShareFormFieldValues(
            selectedProject: self.selectedProject, content: values
        ))
    }
}
