//
//  ScheduleCollectionViewLayoutFactory.swift
//  MIREA Application
//
//  Created by Кирилл Пигалкин on 27.08.2022.
//


import UIKit

public struct ScheduleCollectionViewLayoutFactory {
    static func scheduleFeedLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            guard let section = ScheduleSection.init(rawValue: sectionIndex) else {
                fatalError("Section layout is not implemented :(")
            }
            switch section {
            case .calendar:
                return ScheduleCollectionViewLayoutFactory.createCalendarSectionLayout()
            case .list:
                return ScheduleCollectionViewLayoutFactory.createListSectionLayout()
            case .weekDays:
                return ScheduleCollectionViewLayoutFactory.createWeekDaysSectionLayout()
            }
        }
        return layout
    }
}

extension ScheduleCollectionViewLayoutFactory {
    static func createWeekDaysSectionLayout() -> NSCollectionLayoutSection {
        let dayItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let dayItem = NSCollectionLayoutItem(layoutSize: dayItemSize)
        
        let weekSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(0.1))
        let weekGroup = NSCollectionLayoutGroup.horizontal(layoutSize: weekSize, subitem: dayItem, count: 7)
        
        let section = NSCollectionLayoutSection(group: weekGroup)        
        return section
    }
    
    static func createCalendarSectionLayout() -> NSCollectionLayoutSection {
        
            // Day cell
        let dayItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),heightDimension: .fractionalHeight(1.0))
        let dayItem = NSCollectionLayoutItem(layoutSize: dayItemSize)
        dayItem.contentInsets = .init(top: 5, leading: 5, bottom: 5, trailing: 5)
        
            // Week group with day cells
        let weekSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let weekGroup = NSCollectionLayoutGroup.horizontal(layoutSize: weekSize,subitem: dayItem, count: 7)
        
            // Month group with week groups, squared cells
        let monthGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(0.85714)),
                                                          subitem: weekGroup, count: 6)

        let section = NSCollectionLayoutSection(group: monthGroup)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        return section
    }
    
    static func createListSectionLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(100))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(100))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 20
        section.contentInsets = NSDirectionalEdgeInsets.init(top: 20, leading: 5,
                                                             bottom: 20, trailing: 5)
        return section
    }
}


