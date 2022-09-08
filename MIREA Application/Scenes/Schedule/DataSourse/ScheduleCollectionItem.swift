//
//  ScheduleCollectionitem.swift
//  MIREA Application
//
//  Created by Кирилл Пигалкин on 27.08.2022.
//

import UIKit


enum ScheduleSection: Int {
    case weekDays
    case calendar
    case list
}

struct ScheduleCollectionItem: Hashable {
    
    let uuid = UUID()
        
    enum ItemType {
        case weekDay(configuration: WeekDayConfiguration)
        case calendar(configuration: CalendarConfiguration)
        case list(configuration: ListConfiguration)
    }
    
    let content: ItemType
    
    init(content: ItemType) {
        self.content = content
    }
    
    static func == (lhs: ScheduleCollectionItem, rhs: ScheduleCollectionItem) -> Bool {
        lhs.uuid == rhs.uuid
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }
}

