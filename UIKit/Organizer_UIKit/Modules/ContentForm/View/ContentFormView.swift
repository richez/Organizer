//
//  ContentFormView.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 12/09/2023.
//

import UIKit

@MainActor
protocol ContentFormViewDelegate: AnyObject {
    func didTapOnView()
    func didEditFields(with values: ContentFormFieldValues)
    func didEndEditingLink(_ link: String)
    func didTapNameGetterButton(link: String)
    func didTapSaveButton(with values: ContentFormFieldValues)
}

final class ContentFormView: UIView {
    // MARK: - Properties

    private let viewRepresentation: ContentFormViewRepresentation = .init()
    weak var delegate: ContentFormViewDelegate?

    var isSaveButtonEnabled: Bool = false {
        didSet {
            self.saveButton.isEnabled = self.isSaveButtonEnabled
        }
    }

    // MARK: Views

    let fieldsView: ContentFormFieldsView = .init()
    private let saveButton: FloatingActionButton = .init()
    private let activityIndicatorView: UIActivityIndicatorView = .init()

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
        self.saveButton.setImage(
            self.viewRepresentation.saveButtonImage(named: configuration.saveButtonImageName),
            for: .normal
        )
        self.fieldsView.configure(with: configuration.fields)
    }

    // MARK: - Loader

    func startLoader() {
        self.isUserInteractionEnabled = false
        self.activityIndicatorView.startAnimating()
    }

    func stopLoader() {
        self.isUserInteractionEnabled = true
        self.activityIndicatorView.stopAnimating()
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
        self.setupActivityIndicator()
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

    func setupActivityIndicator() {
        self.activityIndicatorView.hidesWhenStopped = true
        self.activityIndicatorView.color = self.viewRepresentation.activityIndicatorColor
        self.activityIndicatorView.style = self.viewRepresentation.activityIndicatorStyle

        self.addSubview(self.activityIndicatorView)
        self.activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.activityIndicatorView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.activityIndicatorView.topAnchor.constraint(equalTo: self.fieldsView.bottomAnchor, constant: 40)
        ])
    }

    func setupSaveButton() {
        self.saveButton.setup(with: self.viewRepresentation.saveButtonViewRepresentation)
        self.saveButton.isEnabled = self.isSaveButtonEnabled

        self.saveButton.addAction(UIAction(handler: { [weak self] _ in
            guard let self else { return }
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

// MARK: - ContentFormFieldsViewDelegate

extension ContentFormView: ContentFormFieldsViewDelegate {
    func didEditFields(with values: ContentFormFieldValues) {
        self.delegate?.didEditFields(with: values)
    }

    func didEndEditingLink(_ link: String) {
        self.delegate?.didEndEditingLink(link)
    }

    func didTapNameGetterButton(link: String) {
        self.delegate?.didTapNameGetterButton(link: link)
    }
}
