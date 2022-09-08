//
//  NewView.swift
//  MIREA Application
//
//  Created by Кирилл Пигалкин on 06.08.2022.
//

import UIKit

enum NewsSection: Int {
    case news
}

class NewsCell: UICollectionViewCell {
    var id : Int?
}


final class NewsView: UIView, UICollectionViewDelegate {
    
    weak var newsViewControllerDelegate: NewsViewControllerDelegate?
    static var imageDictionary = [Int: UIImage]()
    
    private let newsCellRegistration = UICollectionView.CellRegistration<NewsCell, NewsConfiguration> { cell, indexPath, itemConfiguration in
        cell.contentConfiguration = nil
        cell.id = itemConfiguration.id
        cell.contentConfiguration = itemConfiguration
    }
    
    private lazy var dataSourse = makeDataSource()
    
    private lazy var collectionView: UICollectionView = {
        let view = UICollectionView(
            frame: .zero,
            collectionViewLayout: NewsCollectionViewLayoutFactory.newsFeedLayout())
        view.register(NewsCell.self, forCellWithReuseIdentifier: "cell")
        view.delegate = self
        view.showsVerticalScrollIndicator = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        addSubview(collectionView)
        makeConstraints()
        makeSnapshot()
        self.collectionView.delegate = self
        self.collectionView.backgroundColor = .clear
        print("⭕️ init in NewsView")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("🙋🏻‍♂️ user selected item at \(indexPath)")
        let cell = collectionView.cellForItem(at: indexPath) as? NewsCell
        let id = cell?.id
        newsViewControllerDelegate?.userSelectedCell(indexPath: indexPath, id: id ?? 1)
    }
}

private extension NewsView {
    
    func makeConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.topAnchor.constraint(equalTo: topAnchor)
        ])
    }
    
    func makeSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<NewsSection, NewsCollectionItem>()
        snapshot.appendSections([.news])
        dataSourse.apply(snapshot)
   }
    
    func makeDataSource() -> UICollectionViewDiffableDataSource<NewsSection, NewsCollectionItem> {
        let dataSource = UICollectionViewDiffableDataSource<NewsSection, NewsCollectionItem>(collectionView: collectionView) { [weak self] collectionView,
            indexPath, item in
            guard let self = self,
                let _ = self.dataSourse.sectionIdentifier(for: indexPath.section) else {
                return .init(frame: .zero)
            }
            switch item.content {
            case .news(config: let configuration):
                return collectionView.dequeueConfiguredReusableCell(using: self.newsCellRegistration, for: indexPath, item: configuration)
            }
        }
        return dataSource
    }
}

extension NewsView: NewsViewDelegate {
    func showNews(_ news: NewsModels.News.ViewModel) {
        print("⭕️ showNews in NewsView)")
        var snapshot = dataSourse.snapshot()
        snapshot.appendItems(news.element, toSection: .news)
        dataSourse.apply(snapshot)
    }
}

protocol NewsViewDelegate: AnyObject {
    func showNews(_ news: NewsModels.News.ViewModel)
}

