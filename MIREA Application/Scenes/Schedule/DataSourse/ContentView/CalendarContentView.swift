//
//  CalendarContentView.swift
//  MIREA Application
//
//  Created by Кирилл Пигалкин on 27.08.2022.
//

import UIKit

final class CalendarContentView: UIView, UIContentView {

    var configuration: UIContentConfiguration
    
    private let title: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    
    init(with contentConfiguration: CalendarConfiguration) {
        configuration = contentConfiguration
        super.init(frame: .zero)
        addSubviews()
        configure()
        makeConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        guard let content = configuration as? CalendarConfiguration else {
            return
        }
        title.text = String(content.day)
        setupCellColor(monthStatus: content.isCurrent)
//        print("🗒 Calendar cell configured")
    }
    
    private func addSubviews() {
        addSubview(title)
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
    
    private func setupCellColor(monthStatus: Bool) {
        if monthStatus { title.textColor = Colors.defaultTheme.dirtyWhite }
        else { title.textColor = Colors.defaultTheme.black.withAlphaComponent(0.25) }
    }
    
}

