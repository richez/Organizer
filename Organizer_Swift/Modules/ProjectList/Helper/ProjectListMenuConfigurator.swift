//
//  ProjectListMenuConfigurator.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 20/09/2023.
//

import Foundation

protocol ProjectListMenuConfiguratorProtocol {
    func configuration(numberOfProjects: Int, themes: [String], handler: @escaping () -> Void) -> MenuConfiguration
}

final class ProjectListMenuConfigurator {
    // MARK: - Properties

    private let settings: ProjectListSettings

    // MARK: - Initialization

    init(settings: ProjectListSettings) {
        self.settings = settings
    }
}

// MARK: - ProjectListMenuConfiguratorProtocol

extension ProjectListMenuConfigurator: ProjectListMenuConfiguratorProtocol {
    func configuration(numberOfProjects: Int, themes: [String], handler: @escaping () -> Void) -> MenuConfiguration {
        return .init(
            title: "project".pluralize(count: numberOfProjects) ?? "",
            submenus: [
                self.sortingMenuConfig(handler: handler),
                self.previewStyleMenuConfig(handler: handler),
                self.themeMenuConfig(themes: themes, handler: handler)
            ]
        )
    }
}

// MARK: - Sub Menu

private extension ProjectListMenuConfigurator {
    // MARK: Sorting

    func sortingMenuConfig(handler: @escaping () -> Void) -> MenuConfiguration {
        .init(
            title: "List Sorting",
            imageName: "arrow.up.arrow.down",
            items: [
                .init(title: "Modification Date", isOn: self.settings.sorting == .lastUpdated, handler: { [weak self] in
                    if let self, self.settings.sorting != .lastUpdated {
                        self.settings.sorting = .lastUpdated
                        handler()
                    }
                }),
                .init(title: "Creation Date", isOn: self.settings.sorting == .creation, handler: { [weak self] in
                    if let self, self.settings.sorting != .creation {
                        self.settings.sorting = .creation
                        handler()
                    }
                }),
                .init(title: "Title", isOn: self.settings.sorting == .title, handler: { [weak self] in
                    if let self, self.settings.sorting != .title {
                        self.settings.sorting = .title
                        handler()
                    }
                })
            ],
            submenus: [
                .init(displayInline: true,
                      items: [
                        .init(title: self.settings.sorting != .title ? "Newest on Top" : "A to Z",
                              isOn: self.settings.ascendingOrder,
                              handler: { [weak self] in
                                  self?.settings.ascendingOrder.toggle()
                                  handler()
                              })
                      ])
            ]
        )
    }

    // MARK: Preview Style

    func previewStyleMenuConfig(handler: @escaping () -> Void) -> MenuConfiguration {
        .init(
            title: "Preview Style",
            imageName: "text.alignleft",
            items: [
                .init(title: "Themes", isOn: self.settings.showTheme, handler: { [weak self] in
                    self?.settings.showTheme.toggle()
                    handler()
                }),
                .init(title: "Statistics", isOn: self.settings.showStatistics, handler: { [weak self] in
                    self?.settings.showStatistics.toggle()
                    handler()
                })
            ]
        )
    }

    // MARK: Theme

    func themeMenuConfig(themes: [String], handler: @escaping () -> Void) -> MenuConfiguration {
        return .init(
            title: "Themes",
            imageName: "number",
            singleSelection: true,
            items: [
                .init(title: "All", isOn: self.settings.selectedTheme == .all, handler: { [weak self] in
                    if let self, self.settings.selectedTheme != .all {
                        self.settings.selectedTheme = .all
                        handler()
                    }
                })
            ] + themes.map { theme in
                    .init(title: theme, isOn: self.settings.selectedTheme == .custom(theme)) { [weak self] in
                        if let self, self.settings.selectedTheme != .custom(theme) {
                            self.settings.selectedTheme = .custom(theme)
                            handler()
                        }
                    }
            }
        )
    }
}
