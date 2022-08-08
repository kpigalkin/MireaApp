//
//  NewsCollectionViewLayoutFactory.swift
//  MIREA Application
//
//  Created by Кирилл Пигалкин on 06.08.2022.
//

import UIKit

public struct NewsCollectionViewLayoutFactory {
    
    static func newsFeedLayout() -> UICollectionViewCompositionalLayout {
            
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            guard let section = Section.init(rawValue: sectionIndex) else {
                fatalError("Section layout is not implemented :(")
            }
            return self.createNewsSectionLayout()
            }
        return layout
        }
}

extension NewsCollectionViewLayoutFactory {
    
    static func createNewsSectionLayout() -> NSCollectionLayoutSection {
    let itemSize = NSCollectionLayoutSize(
        widthDimension: .fractionalWidth(1.0),
        heightDimension: .fractionalHeight(1.0)
    )
    let groupSize = NSCollectionLayoutSize(
        widthDimension: .fractionalWidth(1.0),
        heightDimension: .fractionalHeight(0.5)
    )
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    item.contentInsets = NSDirectionalEdgeInsets.init(
        top: 10,
        leading: 10,
        bottom: 0,
        trailing: 10)
        
    let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
    
    let section = NSCollectionLayoutSection(group: group)
        section.accessibilityScroll(.down)
    
    return section
}


}

extension NewsCollectionViewLayoutFactory {

    func createNewsSectionLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
//            heightDimension: .fractionalHeight(1.0)
            heightDimension: .estimated(320)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .fixed(10)

        let section = NSCollectionLayoutSection(group: group)
        section.accessibilityScroll(.down)
        

        return section
    }
}
