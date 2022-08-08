//
//  NewsConfiguration.swift
//  MIREA Application
//
//  Created by Кирилл Пигалкин on 06.08.2022.
//

import UIKit

struct NewsConfiguration: UIContentConfiguration {

    let id: Int
    let name: String
    let image: String

    func makeContentView() -> UIView & UIContentView {
        NewsContentView(with: self)
    }

    func updated(for state: UIConfigurationState) -> NewsConfiguration {
        return self
    }
}

final class NewsContentView: UIView, UIContentView {

    var configuration: UIContentConfiguration

    private let nameOfNewsElement: UILabel = {
        let label = UILabel()
//        label.font = .systemFont(ofSize: 13, weight: .semibold)
        label.font = .italicSystemFont(ofSize: 13)
        label.textColor = .label
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private let image: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "rtu-mirea-image")
        view.layer.borderWidth = 1.0
        view.layer.cornerRadius = 17
        view.layer.masksToBounds = true
        view.backgroundColor = .clear
//        view.contentMode = .scaleAspectFit
        view.contentMode = .scaleToFill
        return view
    }()

    init(with contentConfiguration: NewsConfiguration) {
        configuration = contentConfiguration
        super.init(frame: .zero)
        addSubviews()
        makeConstraints()
        configure()
        backgroundColor = .cyan
        layer.cornerRadius = 20
        layer.masksToBounds = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        guard let content = configuration as? NewsConfiguration else {
            return
        }
        nameOfNewsElement.text = content.name
    }

    private func makeConstraints() {
        nameOfNewsElement.translatesAutoresizingMaskIntoConstraints = false
        image.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
//            image.topAnchor.constraint(equalTo: topAnchor),
//            image.centerXAnchor.constraint(equalTo: centerXAnchor),
//            image.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            image.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            image.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            image.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            image.heightAnchor.constraint(equalToConstant: 200),
            
            nameOfNewsElement.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 5),
            nameOfNewsElement.centerXAnchor.constraint(equalTo: image.centerXAnchor),
            nameOfNewsElement.leadingAnchor.constraint(equalTo: image.leadingAnchor),
            nameOfNewsElement.trailingAnchor.constraint(equalTo: image.trailingAnchor)
        ])
    }
    
    private func addSubviews() {
        addSubview(nameOfNewsElement)
        addSubview(image)
    }
}
