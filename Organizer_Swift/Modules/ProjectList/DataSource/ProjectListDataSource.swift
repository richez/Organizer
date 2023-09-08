//
//  ProjectListDataSource.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 05/09/2023.
//

import UIKit

protocol ProjectListDataSourceDelegate: AnyObject {
    func didTapDelete(on projectDescription: ProjectDescription)
}

final class ProjectListDataSource: UITableViewDiffableDataSource<ProjectListSection, ProjectDescription> {
    // MARK: - Properties
    
    weak var delegate: ProjectListDataSourceDelegate?

    // MARK: - Initialization

    init(tableView: UITableView) {
        tableView.register(ProjectCell.self, forCellReuseIdentifier: ProjectCell.identifier)

        super.init(tableView: tableView) { tableView, indexPath, projectDescription in
            let cell = tableView.dequeueReusableCell(
                withIdentifier: ProjectCell.identifier,
                for: indexPath
            ) as! ProjectCell
            cell.configure(with: projectDescription)
            return cell
        }
    }

    // MARK: - Snapshot

    func applySnapshot(section: ProjectListSection,
                       projectDescriptions: [ProjectDescription],
                       animated: Bool) {
        var snapshot = NSDiffableDataSourceSnapshot<ProjectListSection, ProjectDescription>()
        snapshot.appendSections([section])
        snapshot.appendItems(projectDescriptions, toSection: section)
        self.apply(snapshot, animatingDifferences: animated)
    }

    func applySnapshot(deleting projectDescription: ProjectDescription, animated: Bool) {
        var snapshot = self.snapshot()
        snapshot.deleteItems([projectDescription])
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
