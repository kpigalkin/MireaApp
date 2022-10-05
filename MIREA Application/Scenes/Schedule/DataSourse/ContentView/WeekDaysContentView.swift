//
//  WeekDaysContentView.swift
//  MIREA Application
//
//  Created by Кирилл Пигалкин on 30.08.2022.
//

import UIKit

final class WeekDaysContentView: UIView, UIContentView {
    var configuration: UIContentConfiguration
    
    private let title: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .heavy)
        label.font = .monospacedDigitSystemFont(ofSize: 13, weight: .semibold)
        label.textColor = Color.defaultDark.lightText
        label.textAlignment = .center
        return label
    }()
    
    init(with contentConfiguration: WeekDayConfiguration) {
        configuration = contentConfiguration
        super.init(frame: .zero)
        addSubview(title)
        configure()
        makeConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        guard let content = configuration as? WeekDayConfiguration else { return }
        title.text = content.day
    }

    private func makeConstraints() {
        title.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            title.centerXAnchor.constraint(equalTo: centerXAnchor),
            title.centerYAnchor.constraint(equalTo: centerYAnchor),
            title.widthAnchor.constraint(equalTo: widthAnchor),
            title.heightAnchor.constraint(equalTo: heightAnchor)
        ])
    }
}
