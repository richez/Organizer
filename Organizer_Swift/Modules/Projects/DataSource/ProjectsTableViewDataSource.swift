//
//  ProjectsTableViewDataSource.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 05/09/2023.
//

import UIKit

final class ProjectsTableViewDataSource: UITableViewDiffableDataSource<ProjectsSection, ProjectCellData> {
    // MARK: - Initialization

    init(tableView: UITableView) {
        tableView.register(ProjectsCell.self, forCellReuseIdentifier: ProjectsCell.identifier)

        super.init(tableView: tableView) { tableView, indexPath, project in
            let cell = tableView.dequeueReusableCell(
                withIdentifier: ProjectsCell.identifier,
                for: indexPath
            ) as! ProjectsCell
            cell.configure(with: project)
            return cell
        }
    }

    // MARK: - Snapshot

    func applySnapshot(
        sections: [ProjectsSection],
        projects: (ProjectsSection) -> [ProjectCellData],
        animated: Bool
    ) {
        var snapshot = NSDiffableDataSourceSnapshot<ProjectsSection, ProjectCellData>()
        snapshot.appendSections(sections)
        sections.forEach { section in
            snapshot.appendItems(projects(section), toSection: section)
        }
        self.apply(snapshot, animatingDifferences: animated)
    }
}
