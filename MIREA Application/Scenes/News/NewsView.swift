//
//  NewView.swift
//  MIREA Application
//
//  Created by Кирилл Пигалкин on 06.08.2022.
//

import UIKit

    // MARK:  Custom cell

class NewsCell: UICollectionViewCell {
    static let identifier = "newsCell"
    var id : Int?
}

    // MARK: - NewsView

final class NewsView: UIView, UICollectionViewDelegate, UICollectionViewDataSourcePrefetching {
    weak var newsViewControllerDelegate: NewsViewControllerDelegate?
    
    private let newsCellRegistration = UICollectionView.CellRegistration<NewsCell, NewsConfiguration> { cell, indexPath, itemConfiguration in
        cell.contentConfiguration = nil
        cell.id = itemConfiguration.id
        cell.contentConfiguration = itemConfiguration
    }
    
    private lazy var collectionView: UICollectionView = {
        let view = UICollectionView(
            frame: .zero,
            collectionViewLayout: NewsCollectionViewLayoutFactory.newsFeedLayout())
        view.register(NewsCell.self, forCellWithReuseIdentifier: NewsCell.identifier)
        view.delegate = self
        view.prefetchDataSource = self
        view.showsVerticalScrollIndicator = false
        view.backgroundColor = Color.defaultTheme.lightBlue
        return view
    }()
    
    private lazy var dataSourse = makeDataSource()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        print("⭕️ init in NewsView")
        makeConstraints()
        makeSnapshot()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
        // MARK: CollectionView methods
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? NewsCell
        guard let id = cell?.id else { return }
        newsViewControllerDelegate?.userSelectedCell(id: id)
    }
        
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        let itemsCount = dataSourse.snapshot().numberOfItems
        guard indexPaths.last?.item == itemsCount - 1 else { return } /// Detect last item
        newsViewControllerDelegate?.showLastNews()
    }
    
        // MARK: Setup

    private func makeConstraints() {
        addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.topAnchor.constraint(equalTo: topAnchor)
        ])
    }
    
    private func makeSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<NewsSection, NewsCollectionItem>()
        snapshot.appendSections([.news])
        dataSourse.apply(snapshot)
    }
    
    private func makeDataSource() -> UICollectionViewDiffableDataSource<NewsSection, NewsCollectionItem> {
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

    // MARK: NewsViewDelegate

extension NewsView: NewsViewDelegate {
    func showNews(_ news: NewsModels.News.ViewModel) {
        print("⭕️ showNews in NewsView")
        var snapshot = dataSourse.snapshot()
        snapshot.appendItems(news.element, toSection: .news)
        dataSourse.apply(snapshot)
    }
}
protocol NewsViewDelegate: AnyObject {
    func showNews(_ news: NewsModels.News.ViewModel)
}
