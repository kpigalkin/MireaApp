//
//  NewView.swift
//  MIREA Application
//
//  Created by Кирилл Пигалкин on 06.08.2022.
//

import UIKit

enum Section: Int {
    case news
}

final class NewsView: UIView, UICollectionViewDelegate {
    
    private let newsItemRegistration = UICollectionView.CellRegistration<UICollectionViewCell, NewsConfiguration> { cell, indexPath, itemIdentifier in
            cell.contentConfiguration = nil
            cell.contentConfiguration = itemIdentifier
        
            
        }
    
    private lazy var dataSourse = makeDataSource()
    
    private lazy var collectionView: UICollectionView = {
        let view = UICollectionView(
            frame: .zero,
            collectionViewLayout: NewsCollectionViewLayoutFactory.newsFeedLayout())

        view.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
//        view.backgroundColor = .gray
        view.delegate = self
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)
//        backgroundColor = .magenta
        
        addSubview(collectionView)
        makeConstraints()
        createSections()
        self.collectionView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension NewsView {
    
    func makeConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func createSections() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, NewsCollectionItem>()
        snapshot.appendSections([.news])
        dataSourse.apply(snapshot)
   }
    
    func makeDataSource() -> UICollectionViewDiffableDataSource<Section, NewsCollectionItem> {
        let dataSource = UICollectionViewDiffableDataSource<Section, NewsCollectionItem>(collectionView: collectionView) { [weak self] collectionView,
            indexPath, item in
            guard let self = self,
                let _ = self.dataSourse.sectionIdentifier(for: indexPath.section) else {
                return .init(frame: .zero)
            }
            switch item.content {
            case .news(config: let configuration):
                return collectionView.dequeueConfiguredReusableCell(using: self.newsItemRegistration, for: indexPath, item: configuration)
            }
        }
        return dataSource
    }
}

extension NewsView: NewsViewDelegate {
    func showNews(_ news: NewsModels.News.ViewModel) {
        print("⭕️ showNews in NewsView)")
        var snapshot = dataSourse.snapshot()
        snapshot.appendItems(news.news, toSection: .news)
        dataSourse.apply(snapshot)
    }
}

protocol NewsViewDelegate: AnyObject {
    func showNews(_ news: NewsModels.News.ViewModel)
}
