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
        let dayItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.142),
                                                 heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: dayItemSize)
        let weekSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalWidth(0.1))
        let weekGroup = NSCollectionLayoutGroup.horizontal(layoutSize: weekSize, subitems: [item])
        weekGroup.contentInsets = .init(top: 0, leading: Constants.heightPadding*2,
                                        bottom: 0, trailing: Constants.heightPadding*2)
        let section = NSCollectionLayoutSection(group: weekGroup)        
        return section
    }
    
    static func createCalendarSectionLayout() -> NSCollectionLayoutSection {
        let spacing: CGFloat = 0
    
            // Day cell
        let dayItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.142),
                                                 heightDimension: .fractionalHeight(1.0))
        let dayItem = NSCollectionLayoutItem(layoutSize: dayItemSize)
        dayItem.contentInsets = .init(top: spacing, leading: spacing,
                                   bottom: spacing, trailing: spacing)
        
            // Week group with day cells
        let weekSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalWidth(1.0))
        let weekGroup = NSCollectionLayoutGroup.horizontal(layoutSize: weekSize, subitems: [dayItem])
        weekGroup.contentInsets = .init(top: 0, leading: Constants.heightPadding*2,
                                        bottom: 0, trailing: Constants.heightPadding*2)
        
            // Month group with week groups
        let monthGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(0.36)),
            subitem: weekGroup, count: 6)
        let section = NSCollectionLayoutSection(group: monthGroup)
        section.contentInsets = .init(top: 0, leading: 0,
                                      bottom: Constants.heightPadding, trailing: 0)
        

        
            // Setup scroll direction
        section.orthogonalScrollingBehavior = .groupPagingCentered
        
        return section
    }
    
    static func createListSectionLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(100))
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(100))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
//        item.contentInsets = NSDirectionalEdgeInsets.init(
//            top: Constants.heightPadding,
//            leading: Constants.padding / 2,
//            bottom: 0,
//            trailing: Constants.padding / 2)
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = Constants.heightPadding
        section.contentInsets = NSDirectionalEdgeInsets.init(
            top: Constants.heightPadding,
            leading: Constants.padding,
            bottom: Constants.padding,
            trailing: Constants.padding)
        return section
    }
}


