//
//  NewsCollectionItem.swift
//  MIREA Application
//
//  Created by Кирилл Пигалкин on 06.08.2022.
//

import UIKit

enum NewsSection: Int {
    case news
}

struct NewsCollectionItem: Hashable {
    
    let content: NewsConfiguration
    let uuid = UUID()
    
    init(content: NewsConfiguration) {
        self.content = content
    }
    
    static func == (lhs: NewsCollectionItem, rhs: NewsCollectionItem) -> Bool {
        lhs.uuid == rhs.uuid
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }
}
