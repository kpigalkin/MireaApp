//
//  NewsCollectionItem.swift
//  MIREA Application
//
//  Created by Кирилл Пигалкин on 06.08.2022.
//

import UIKit

struct NewsCollectionItem: Hashable {
    
    let uuid = UUID()
        
    enum ItemType {
        case news(config: NewsConfiguration)
    }
    
    let content: ItemType
    
    init(content: ItemType) {
        self.content = content
    }
    
    static func == (lhs: NewsCollectionItem, rhs: NewsCollectionItem) -> Bool {
        lhs.uuid == rhs.uuid
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }
}
