//
//  ProjectListDataSource.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 05/09/2023.
//

import UIKit

final class ProjectListDataSource: UITableViewDiffableDataSource<ProjectListSection, ProjectCellDescription> {
    // MARK: - Properties
    
    var dataStore: ProjectListDataStore?

    // MARK: - Initialization

    init(tableView: UITableView) {
        tableView.register(ProjectCell.self, forCellReuseIdentifier: ProjectCell.identifier)

        super.init(tableView: tableView) { tableView, indexPath, projectCellDescription in
            let cell = tableView.dequeueReusableCell(
                withIdentifier: ProjectCell.identifier,
                for: indexPath
            ) as! ProjectCell
            cell.configure(with: projectCellDescription)
            return cell
        }
    }

    // MARK: - Snapshot

    func applySnapshot(dataStore: ProjectListDataStore, animated: Bool) {
        var snapshot = NSDiffableDataSourceSnapshot<ProjectListSection, ProjectCellDescription>()
        snapshot.appendSections(dataStore.sections)
        dataStore.sections.forEach { section in
            let projectsCellDescriptions = dataStore.projectCellDescriptions(for: section)
            snapshot.appendItems(projectsCellDescriptions, toSection: section)
        }

        self.apply(snapshot, animatingDifferences: animated)
        self.dataStore = dataStore
    }

    func applySnapshot(deleting projectCellDescription: ProjectCellDescription) {
        var snapshot = self.snapshot()
        snapshot.deleteItems([projectCellDescription])
        self.apply(snapshot, animatingDifferences: true)

        self.dataStore?.deleteProject(description: projectCellDescription)
    }

    // MARK: - UITableViewDataSource

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath) {
            switch editingStyle {
            case .delete:
                guard let projectCellDescription = self.dataStore?.projectCellDescription(at: indexPath) else { return }
                self.applySnapshot(deleting: projectCellDescription)
            default:
                break
            }
        }
}
