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
    let imageUrl: URL
    var image: UIImage?

    func makeContentView() -> UIView & UIContentView {
        NewsContentView(with: self)
    }

    func updated(for state: UIConfigurationState) -> NewsConfiguration {
        return self
    }
}

final class NewsContentView: UIView, UIContentView {

    var configuration: UIContentConfiguration
    private var aspectRatio: CGFloat?


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
        return view
    }()
    
    private var id: Int?

    init(with contentConfiguration: NewsConfiguration) {
        configuration = contentConfiguration
        super.init(frame: .zero)
        addSubviews()
        configure()
        makeConstraints()
        makingShadows()
        backgroundColor = Colors.defaultTheme.darkBlue.withAlphaComponent(0.2)
//        backgroundColor =
//        backgroundColor = .systemGray4
//        #BCB38D
        layer.cornerRadius = 17
        layer.masksToBounds = false
        layer.shadowRadius = 8
        layer.shadowOpacity = 1.0
        layer.shadowOffset = CGSize(width: 0, height: 10)
        layer.shadowColor = UIColor.darkGray.cgColor
        
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
        picture.image = content.image
        // calculate aspect ratio and set default image
        if picture.image == nil {
            picture.image = UIImage(named: "rtu-mirea-image")
        }
        aspectRatio = picture.image!.size.width / picture.image!.size.height
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
            picture.heightAnchor.constraint(equalTo: picture.widthAnchor, multiplier: 1/aspectRatio!),
            
            title.topAnchor.constraint(equalTo: picture.bottomAnchor, constant: 10),
            title.leadingAnchor.constraint(equalTo: picture.leadingAnchor, constant: 10),
            title.trailingAnchor.constraint(equalTo: picture.trailingAnchor, constant: -10),
            title.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
    
    private func makingShadows() {
        picture.layer.shadowRadius = 20
        picture.layer.shadowOpacity = 2.0
        picture.layer.shadowOffset = CGSize(width: 20, height: 20)
        picture.layer.shadowColor = UIColor.black.cgColor
    }
}
