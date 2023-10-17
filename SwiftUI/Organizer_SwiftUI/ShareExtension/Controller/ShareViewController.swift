//
//  ShareViewController.swift
//  ShareExtension
//
//  Created by Thibaut Richez on 17/10/2023.
//

import SwiftData
import SwiftUI
import UIKit

final class ShareViewController: UIViewController {
    // MARK: - Properties

    private lazy var contentView: ShareView = .init()

    private let viewModel: ShareViewModel = .init()
    private var loadingTask: Task<Void, Never>?

    // MARK: - Life Cycle

    override func loadView() {
        self.view = self.contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.loadContent()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        self.loadingTask?.cancel()
    }
}

private extension ShareViewController {
    // MARK: - Load

    func loadContent() {
        self.contentView.startLoader()

        self.loadingTask = Task { [weak self] in
            guard let self else { return }
            do {
                let extensionItem = self.extensionContext?.inputItems.first as? NSExtensionItem
                let content = await self.viewModel.loadContent(in: extensionItem)
                try Task.checkCancellation()
                self.contentView.stopLoader()
                self.addFormController(with: content)
            } catch {
                print("Fail to load content: \(error)")
                self.contentView.stopLoader()
            }
        }
    }

    // MARK: - Child

    func addFormController(with content: ShareContent) {
        let formView = ShareForm(content: content, finishAction: { [weak self] in
            self?.extensionContext?.completeRequest(returningItems: nil)
        })
            .modelContainer(for: [Project.self, ProjectContent.self], isAutosaveEnabled: true)
        let hostingController = UIHostingController(rootView: formView)
        self.addChild(hostingController)
        hostingController.view.frame = self.view.frame
        self.view.addSubview(hostingController.view)
        hostingController.didMove(toParent: self)
    }
}
