//
//  ViewControllerFactory.swift
//  Organizer_UIKit
//
//  Created by Thibaut Richez on 04/10/2023.
//

import SafariServices
import UIKit

enum ViewControllerFactory {
    // MARK: - Project List

    static func projectList(coordinator: ProjectListCoordinator) -> ProjectListViewController {
        let dataStore = ProjectDataStore.shared
        let settings = ProjectListSettings()
        let fetchDescriptor = ProjectListFetchDescriptor(settings: settings)
        let menuConfigurator = ProjectListMenuConfigurator(settings: settings)
        let projectListViewModel = ProjectListViewModel(
            dataStore: dataStore, settings: settings, fetchDescriptor: fetchDescriptor, menuConfigurator: menuConfigurator
        )

        return ProjectListViewController(viewModel: projectListViewModel, coordinator: coordinator)
    }

    // MARK: - Project Form

    static func projectForm(with mode: ProjectFormMode, coordinator: ProjectFormCoordinator) -> ProjectFormViewController {
        let dataStore = ProjectDataStore.shared
        let notificationCenter = NotificationCenter.default
        let projectFormViewModel = ProjectFormViewModel(mode: mode, dataStore: dataStore, notificationCenter: notificationCenter)

        return ProjectFormViewController(viewModel: projectFormViewModel, coordinator: coordinator)
    }

    // MARK: - Content List

    static func contentList(with project: Project, coordinator: ContentListCoordinator) -> ContentListViewController {
        let settings = ContentListSettings(suiteName: project.id.uuidString)
        let fetchDescriptor = ContentListFetchDescriptor(settings: settings)
        let menuConfigurator = ContentListMenuConfigurator(settings: settings)
        let notificationCenter = NotificationCenter.default
        let contentListViewModel = ContentListViewModel(
            project: project,
            settings: settings,
            fetchDescriptor: fetchDescriptor,
            menuConfigurator: menuConfigurator,
            notificationCenter: notificationCenter
        )

        return ContentListViewController(viewModel: contentListViewModel, coordinator: coordinator)
    }

    // MARK: - Content Form

    static func contentForm(with mode: ContentFormMode, project: Project, coordinator: ContentFormCoordinator) -> ContentFormViewController {
        let uRLMetadataConfiguration = URLMetadataConfiguration(shouldFetchSubresources: false, timeout: 20)
        let urlMetadataProvider = URLMetadataProvider(configuration: uRLMetadataConfiguration)
        let notificationCenter = NotificationCenter.default
        let contentFormViewModel = ContentFormViewModel(
            mode: mode,
            project: project,
            urlMetadataProvider: urlMetadataProvider,
            notificationCenter: notificationCenter
        )

        return ContentFormViewController(viewModel: contentFormViewModel, coordinator: coordinator)
    }

    // MARK: - Safari

    static func safari(with url: URL) -> SFSafariViewController {
        let safariViewController = SFSafariViewController(url: url)
        safariViewController.dismissButtonStyle = .close
        safariViewController.preferredBarTintColor = .background
        return safariViewController
    }
}
