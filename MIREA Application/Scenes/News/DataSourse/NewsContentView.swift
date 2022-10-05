//
//  NewsConfiguration.swift
//  MIREA Application
//
//  Created by Кирилл Пигалкин on 06.08.2022.
//

import UIKit
import SDWebImage

final class NewsContentView: UIView, UIContentView {
    
    var configuration: UIContentConfiguration {
        didSet {
            configure()
        }
    }
    
    static var imageDictionary = [Int: UIImage?]()
    private var id: Int?

    private let title: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textColor = Color.defaultDark.lightText
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    let picture: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 15
        view.layer.masksToBounds = true
        view.backgroundColor = .clear
        view.contentMode = .scaleAspectFill
        view.layer.shadowRadius = 10
        view.layer.shadowOpacity = 0
        view.layer.shadowOffset = CGSize(width: 0, height: -7)
        view.layer.shadowColor = UIColor.black.cgColor
        return view
    }()
    
    init(with contentConfiguration: NewsConfiguration) {
        configuration = contentConfiguration
        super.init(frame: .zero)
        setupLayer()
        addSubviews()
        makeConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        guard let content = configuration as? NewsConfiguration else { return }
        setupImage(id: content.id, imageUrl: content.imageUrl)
        id = content.id
        title.text = content.name
    }
    
    private func addSubviews() {
        addSubview(title)
        addSubview(picture)
    }

    private func makeConstraints() {
        title.translatesAutoresizingMaskIntoConstraints = false
        picture.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            picture.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            picture.widthAnchor.constraint(equalTo: widthAnchor, constant: -20),
            picture.centerXAnchor.constraint(equalTo: centerXAnchor),
            picture.heightAnchor.constraint(equalTo: picture.widthAnchor, multiplier: 0.625),
            
            title.topAnchor.constraint(equalTo: picture.bottomAnchor, constant: 10),
            title.leadingAnchor.constraint(equalTo: picture.leadingAnchor, constant: 5),
            title.trailingAnchor.constraint(equalTo: picture.trailingAnchor, constant: -5),
            title.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
}

extension NewsContentView {
    private func setupImage(id: Int, imageUrl: URL?) {
        guard let imageUrl = imageUrl else {
            return
        }
        picture.sd_setImage(with: imageUrl)
    }
    
    private func setupLayer() {
        backgroundColor = Color.defaultDark.lightBlack
        layer.cornerRadius = 17
        layer.masksToBounds = true
    }
}
