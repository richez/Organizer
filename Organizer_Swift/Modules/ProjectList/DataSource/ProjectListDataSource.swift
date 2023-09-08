//
//  ProjectListDataSource.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 05/09/2023.
//

import UIKit

protocol ProjectListDataSourceDelegate: AnyObject {
    func didTapDelete(on projectDescription: ProjectCellDescription)
}

final class ProjectListDataSource: UITableViewDiffableDataSource<ProjectListSection, ProjectCellDescription> {
    // MARK: - Properties
    
    weak var delegate: ProjectListDataSourceDelegate?

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

    func applySnapshot(section: ProjectListSection,
                       projectDescriptions: [ProjectCellDescription],
                       animated: Bool) {
        var snapshot = NSDiffableDataSourceSnapshot<ProjectListSection, ProjectCellDescription>()
        snapshot.appendSections([section])
        snapshot.appendItems(projectDescriptions, toSection: section)
        self.apply(snapshot, animatingDifferences: animated)
    }

    func applySnapshot(deleting projectCellDescription: ProjectCellDescription, animated: Bool) {
        var snapshot = self.snapshot()
        snapshot.deleteItems([projectCellDescription])
        self.apply(snapshot, animatingDifferences: animated)
    }


    // MARK: - UITableViewDataSource

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath
    ) {
        switch editingStyle {
        case .delete:
            guard let projectDescription = self.itemIdentifier(for: indexPath) else { return }
            self.delegate?.didTapDelete(on: projectDescription)
        default:
            break
        }
    }
}
