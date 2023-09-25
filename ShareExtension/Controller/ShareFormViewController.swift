//
//  ShareFormViewController.swift
//  ShareExtension
//
//  Created by Thibaut Richez on 21/09/2023.
//

import UIKit

final class ShareFormViewController: UIViewController {
    // MARK: - Properties

    private lazy var contentView: ShareFormView = .init()
    private let viewModel: ShareFormViewModel = .init()

    // MARK: - Life Cycle

    override func loadView() {
        self.view = self.contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setup()
    }
}


private extension ShareFormViewController {
    // MARK: - Setup

    func setup() {
        self.contentView.delegate = self
        self.contentView.startActivityIndicator()

        Task {
            do {
                let extensionItem = self.extensionContext?.inputItems.first as? NSExtensionItem
                let viewConfiguration = try await self.viewModel.viewConfiguration(with: extensionItem)
                self.contentView.stopActivityIndicator()
                self.contentView.configure(with: viewConfiguration)
            } catch {
                print("Fail de load view configuration due to error: \(error)")
                self.contentView.stopActivityIndicator()
                self.contentView.configure(with: self.viewModel.erroredViewConfiguration)
            }
        }
    }
}

// MARK: - ShareFormViewDelegate

extension ShareFormViewController: ShareFormViewDelegate {
    func didEditFields(selectedProject: ProjectSelectedItem?, type: String, name: String, theme: String, link: String) {
        self.contentView.isProjectTextFieldHidden = self.viewModel.shouldHideProjectTextField(for: selectedProject)
        self.contentView.isSaveButtonEnabled = self.viewModel.isFieldsValid(
            selectedProject: selectedProject, type: type, name: name, theme: theme, link: link
        )
    }
    
    func didTapOnView() {
        self.view.endEditing(true)
    }
    
    func didTapSaveButton(selectedProject: ProjectSelectedItem?, type: String, name: String, theme: String, link: String) {
        // TODO: handle save
    }
}
