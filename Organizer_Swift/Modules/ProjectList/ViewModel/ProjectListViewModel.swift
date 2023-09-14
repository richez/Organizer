//
//  ProjectListViewModel.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 05/09/2023.
//

import Foundation

final class ProjectListViewModel {
    // MARK: - Properties

    private let dataStore: ProjectDataStoreReader & ProjectDataStoreDeleter
    private var settings: ProjectListSettings

    // MARK: - Initialization

    init(dataStore: ProjectDataStoreReader & ProjectDataStoreDeleter = ProjectDataStore.shared,
         settings: ProjectListSettings = .init()) {
        self.dataStore = dataStore
        self.settings = settings
    }
}

// MARK: - Public

extension ProjectListViewModel {
    // MARK: Properties

    var navigationBarTitle: String {
        switch self.settings.selectedTheme {
        case .all:
            return "Projects"
        case .custom(let selectedTheme):
            return "Projects (#\(selectedTheme))"
        }
    }

    var rightBarImageName: String { "ellipsis" }
    var section: ProjectListSection { .main }

    // MARK: Data Store

    func fetchProjectDescriptions() throws -> [ProjectDescription] {
        do {
            let projects = try self.dataStore.fetch()
            return projects.map { project in
                return ProjectDescription(
                    id: project.id,
                    title: project.title,
                    theme: project.themes.map { "#\($0)" }.joined(separator: " "),
                    statistics: project.statistics,
                    lastUpdatedDate: project.lastUpdatedDate.formatted(.dateTime.day().month(.abbreviated))
                )
            }
        } catch {
            throw ProjectListViewModelError.fetch(error)
        }
    }

    func project(with projectID: UUID?) throws -> Project {
        guard let projectID else { throw ProjectListViewModelError.notFound(nil) }

        do {
            return try self.dataStore.project(with: projectID)
        } catch {
            throw ProjectListViewModelError.notFound(error)
        }
    }

    func deleteProject(with id: UUID) throws {
        do {
            try self.dataStore.delete(projectID: id)
        } catch {
            throw ProjectListViewModelError.delete(error)
        }
    }

    // MARK: Menu

    func menuConfiguration(handler: @escaping () -> Void) -> MenuConfiguration {
        let projects = try? self.dataStore.fetch()
        return .init(
            title: "project".pluralize(count: projects?.count ?? 0) ?? "",
            submenus: [
                self.sortingMenuConfig(handler: handler),
                self.previewStyleMenuConfig(handler: handler),
                self.themeMenuConfig(projects: projects, handler: handler)
            ]
        )
    }
}

// MARK: - Helpers

private extension ProjectListViewModel {
    // MARK: Menu

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
            submenus: self.settings.sorting != .title ? [
                .init(displayInline: true,
                      items: [
                        .init(title: "Newest on top", isOn: self.settings.ascendingOrder, handler: { [weak self] in
                            self?.settings.ascendingOrder.toggle()
                            handler()
                        })
                      ])
            ] : []
        )
    }

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

    func themeMenuConfig(projects: [Project]?, handler: @escaping () -> Void) -> MenuConfiguration {
        let existingThemes = projects?.lazy.flatMap(\.themes) ?? []
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
            ] + existingThemes.map { theme in
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

// MARK: - Project

private extension Project {
    var statistics: String {
        guard let contentStatistics else { return "" }
        return "\(contentStatistics) (\(contentTypeStatistics))"
    }

    var contentStatistics: String? {
        "content".pluralize(count: self.contents.count)
    }

    var contentTypeStatistics: String {
        return ProjectContentType.allCases.compactMap { type in
            let numberOfContent =  self.contents.lazy.filter { $0.type == type }.count
            return type.rawValue.pluralize(count: numberOfContent)
        }.joined(separator: ", ")
    }
}

private extension String {
    func pluralize(count: Int) -> String? {
        guard count > 0 else { return nil }
        return count >= 2 ? "\(count) \(self)s" : "\(count) \(self)"
    }
}
