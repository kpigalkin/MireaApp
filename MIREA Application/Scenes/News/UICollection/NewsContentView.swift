//
//  NewsConfiguration.swift
//  MIREA Application
//
//  Created by Кирилл Пигалкин on 06.08.2022.
//

import UIKit

final class NewsContentView: UIView, UIContentView {

    var configuration: UIContentConfiguration
    private var aspectRatio: CGFloat = 16/9
    static var imageDictionary = [Int: UIImage]()

    private let title: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .heavy)
        label.textColor = Colors.defaultTheme.dirtyWhite
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private let picture: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 17
        view.layer.masksToBounds = true
        view.backgroundColor = .clear
        view.contentMode = .scaleAspectFit
        view.image = UIImage(named: "rtu-mirea-image")!
        return view
    }()
    
    private var id: Int?

    init(with contentConfiguration: NewsConfiguration) {
        configuration = contentConfiguration
        super.init(frame: .zero)
        addSubviews()
        configure()
        makeConstraints()
        setupLayers()
        backgroundColor = Colors.defaultTheme.darkBlue.withAlphaComponent(0.2)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        guard let content = configuration as? NewsConfiguration else {
            return
        }
        id = content.id
        title.text = content.name
        
        // MARK: Setup image
        let imageExists = NewsContentView.imageDictionary[content.id] != nil
        if imageExists {
            picture.image = NewsContentView.imageDictionary[content.id]
                print("🌄✅ image already exists")
        } else {
            DispatchQueue.global().async {
                do {
                    let data = try Data(contentsOf: content.imageUrl)
                    let image = UIImage(data: data)
                    NewsContentView.imageDictionary[content.id] = image
                    DispatchQueue.main.async {
                        self.picture.image = image
                        self.aspectRatio = self.picture.image!.size.width / self.picture.image!.size.height
                        print("🌄⬆ image downloaded and setted")
                    }
                }
                catch {
                    print("❌ Image \(content.name) isn't downloaded")
                }
            }
        }
        print("✄ cellConfigured")
    }
    
    private func addSubviews() {
        addSubview(title)
        addSubview(picture)
    }

    private func makeConstraints() {
        title.translatesAutoresizingMaskIntoConstraints = false
        picture.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            picture.topAnchor.constraint(equalTo: topAnchor, constant: Constants.padding),
            picture.widthAnchor.constraint(equalTo: widthAnchor, constant: -Constants.heightPadding),
            picture.centerXAnchor.constraint(equalTo: centerXAnchor),
            picture.heightAnchor.constraint(equalTo: picture.widthAnchor, multiplier: 1/aspectRatio),
            
            title.topAnchor.constraint(equalTo: picture.bottomAnchor, constant: Constants.heightPadding),
            title.leadingAnchor.constraint(equalTo: picture.leadingAnchor, constant: 10),
            title.trailingAnchor.constraint(equalTo: picture.trailingAnchor, constant: -10),
            title.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
    
    private func setupLayers() {
        layer.cornerRadius = 17
        layer.masksToBounds = false
        layer.shadowRadius = 8
        layer.shadowOpacity = 1.0
        layer.shadowOffset = CGSize(width: 0, height: 10)
        layer.shadowColor = UIColor.darkGray.cgColor
        
        picture.layer.shadowRadius = 20
        picture.layer.shadowOpacity = 2.0
        picture.layer.shadowOffset = CGSize(width: 20, height: 20)
        picture.layer.shadowColor = UIColor.black.cgColor
    }
}
