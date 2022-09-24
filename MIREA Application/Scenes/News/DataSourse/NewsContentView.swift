//
//  NewsConfiguration.swift
//  MIREA Application
//
//  Created by Кирилл Пигалкин on 06.08.2022.
//

import UIKit

final class NewsContentView: UIView, UIContentView {
    var configuration: UIContentConfiguration
    private var aspectRatio: CGFloat = 0.625 /// 10:16
    static var imageDictionary = [Int: UIImage?]()
    private var id: Int?

    private let title: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textColor = Color.defaultTheme.lightText
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private let picture: UIImageView = {
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
        configure()
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
            picture.topAnchor.constraint(equalTo: topAnchor, constant: Const.space),
            picture.widthAnchor.constraint(equalTo: widthAnchor, constant: -Const.middleSpace),
            picture.centerXAnchor.constraint(equalTo: centerXAnchor),
            picture.heightAnchor.constraint(equalTo: picture.widthAnchor, multiplier: aspectRatio),
            
            title.topAnchor.constraint(equalTo: picture.bottomAnchor, constant: Const.space),
            title.leadingAnchor.constraint(equalTo: picture.leadingAnchor, constant: Const.minSpace),
            title.trailingAnchor.constraint(equalTo: picture.trailingAnchor, constant: -Const.minSpace),
            title.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Const.space)
        ])
    }
}

extension NewsContentView {
    private func setupImage(id: Int, imageUrl: URL?) {
                
        if let image = NewsContentView.imageDictionary[id] {
            picture.image = image
            print("🌄✅ image already exists")
        } else {
            DispatchQueue.global().async {
                do {
                    let defaultImageURL = URL(string: "https://www.mirea.ru/upload/medialibrary/d07/RTS_colour.jpg")!
                    let url = imageUrl ?? defaultImageURL
                    let data = try Data(contentsOf: url)
                    guard let image = UIImage(data: data) else { return }
                    DispatchQueue.main.async {
                        self.picture.image = image
                        NewsContentView.imageDictionary[id] = image
                        print("🌄⬆ image downloaded and setted")
                    }
                }
                catch {
                    print("❌ Image isn't downloaded")
                }
            }
        }
    }
    
    private func setupLayer() {
        backgroundColor = Color.defaultTheme.lightBlack
        layer.cornerRadius = 17
        layer.masksToBounds = true
    }
}
