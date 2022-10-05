//
//  PersonCell.swift
//  MIREA Application
//
//  Created by Кирилл Пигалкин on 30.09.2022.
//

import UIKit

final class PersonCell: UITableViewCell {
    static let identifier = "tableCell"
    var id: Int?
    var name: String?

    override func updateConfiguration(using state: UICellConfigurationState) {
        super.updateConfiguration(using: state)

        var contentConfig = defaultContentConfiguration().updated(for: state)
        contentConfig.text = name
        contentConfig.textProperties.color = .white

        var backgroundConfig = backgroundConfiguration?.updated(for: state)
        backgroundConfig?.backgroundColor = .clear

        if state.isHighlighted || state.isSelected {
            backgroundConfig?.backgroundColor = Color.defaultDark.orange
            contentConfig.textProperties.color = .white
        }
        contentConfiguration = contentConfig
        backgroundConfiguration = backgroundConfig
    }
}
