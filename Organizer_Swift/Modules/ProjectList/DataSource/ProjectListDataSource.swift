//
//  ProjectListDataSource.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 05/09/2023.
//

import UIKit

final class ProjectListDataSource: UITableViewDiffableDataSource<ProjectListSection, ProjectCellData> {
    // MARK: - Properties
    
    var dataStore: ProjectListDataStore?

    // MARK: - Initialization

    init(tableView: UITableView) {
        tableView.register(ProjectCell.self, forCellReuseIdentifier: ProjectCell.identifier)

        super.init(tableView: tableView) { tableView, indexPath, projectCellData in
            let cell = tableView.dequeueReusableCell(
                withIdentifier: ProjectCell.identifier,
                for: indexPath
            ) as! ProjectCell
            cell.configure(with: projectCellData)
            return cell
        }
    }

    // MARK: - Snapshot

    func applySnapshot(dataStore: ProjectListDataStore, animated: Bool) {
        var snapshot = NSDiffableDataSourceSnapshot<ProjectListSection, ProjectCellData>()
        snapshot.appendSections(dataStore.sections)
        dataStore.sections.forEach { section in
            let projectsCellData = dataStore.projectListCellData(for: section)
            snapshot.appendItems(projectsCellData, toSection: section)
        }

        self.apply(snapshot, animatingDifferences: animated)
        self.dataStore = dataStore
    }

    func applySnapshot(deleting projectCellData: ProjectCellData) {
        var snapshot = self.snapshot()
        snapshot.deleteItems([projectCellData])
        self.apply(snapshot, animatingDifferences: true)

        self.dataStore?.deleteProject(with: projectCellData.id)
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
                guard let projectCellData = self.dataStore?.projectCellData(at: indexPath) else { return }
                self.applySnapshot(deleting: projectCellData)
            default:
                break
            }
        }
}
