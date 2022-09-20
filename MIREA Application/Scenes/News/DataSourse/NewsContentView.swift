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
        label.textColor = Colors.defaultTheme.lightBlack.withAlphaComponent(0.9)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private let picture: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 17
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
            picture.topAnchor.constraint(equalTo: topAnchor),
            picture.widthAnchor.constraint(equalTo: widthAnchor),
            picture.centerXAnchor.constraint(equalTo: centerXAnchor),
            picture.heightAnchor.constraint(equalTo: picture.widthAnchor, multiplier: aspectRatio),
            
            title.topAnchor.constraint(equalTo: picture.bottomAnchor, constant: Constants.space),
            title.leadingAnchor.constraint(equalTo: picture.leadingAnchor, constant: Constants.space),
            title.trailingAnchor.constraint(equalTo: picture.trailingAnchor, constant: -Constants.space),
            title.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.space)
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
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.systemMaterialLight)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.frame = self.bounds
        addSubview(blurEffectView)
        
        layer.cornerRadius = 20
        layer.masksToBounds = true
        layer.shadowRadius = 10
        layer.shadowOpacity = 0
        layer.shadowOffset = CGSize(width: 0, height: -10)
        layer.shadowColor = UIColor.black.cgColor
    }
}
