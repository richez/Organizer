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

        self.contentView.configure(with: self.viewModel.viewConfiguration)
    }
}

// MARK: - ShareFormViewDelegate

extension ShareFormViewController: ShareFormViewDelegate {
    func didUpdateProjectMenu(to selectedProject: ProjectSelectedItem) {
        self.contentView.isProjectTextFieldHidden = self.viewModel.shouldHideProjectTextField(for: selectedProject)
    }
    
    func didEditFields(selectedProject: ProjectSelectedItem?, type: String, name: String, theme: String, link: String) {

    }
    
    func didTapOnView() {
        self.view.endEditing(true)
    }
    
    func didTapSaveButton(selectedProject: ProjectSelectedItem?, type: String, name: String, theme: String, link: String) {

    }
}
