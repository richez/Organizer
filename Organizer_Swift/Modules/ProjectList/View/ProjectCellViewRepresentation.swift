//
//  ProjectCellViewRepresentation.swift
//  Organizer_Swift
//
//  Created by Thibaut Richez on 05/09/2023.
//

import UIKit

struct ProjectCellViewRepresentation {
    var backgroundColor: UIColor = .background
    var selectedBackgroundColor: UIColor = .projectCellSelectedBackground

    var titleColor: UIColor = .projectCellTitle
    var titleFont: UIFont = .systemFont(ofSize: 15, weight: .bold)

    var statisticsColor: UIColor = .projectCellStatistics
    var statisticsFont: UIFont = .systemFont(ofSize: 12, weight: .regular)

    var themeColor: UIColor = .projectCellTheme
    var themeFont: UIFont = .systemFont(ofSize: 12, weight: .regular)

    var dateColor: UIColor = .projectCellDate
    var dateFont: UIFont = .systemFont(ofSize: 13, weight: .light)

    var separatorColor: UIColor = .projectCellSeparator
    var separatorHeight: CGFloat = 1
}
