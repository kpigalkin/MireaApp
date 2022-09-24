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
            guard let _ = NewsSection.init(rawValue: sectionIndex) else {
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
            widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(300))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(300))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = Const.longSpace
        section.accessibilityScroll(.previous)
        section.contentInsets = NSDirectionalEdgeInsets.init(
            top: Const.space,
            leading: Const.space,
            bottom: Const.longSpace,
            trailing: Const.space)
        return section
    }
}

