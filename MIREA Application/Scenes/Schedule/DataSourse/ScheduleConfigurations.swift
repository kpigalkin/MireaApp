//
//  ScheduleConfiguration.swift
//  MIREA Application
//
//  Created by Кирилл Пигалкин on 27.08.2022.
//

import UIKit

struct CalendarConfiguration: UIContentConfiguration {
    
    let id: Int
    let day: Int
    let month: String
    let isCurrent: Bool
    let weekNumber: Int

    func makeContentView() -> UIView & UIContentView {
        CalendarContentView(with: self)
    }

    func updated(for state: UIConfigurationState) -> CalendarConfiguration {
        return self
    }
}

struct ListConfiguration: UIContentConfiguration {
    
    let id: Int
    let name, room, type, group: String
    let number, wdNum: Int

    func makeContentView() -> UIView & UIContentView {
        ListContentView(with: self)
    }

    func updated(for state: UIConfigurationState) -> ListConfiguration {
        return self
    }
}

struct WeekDayConfiguration: UIContentConfiguration {

    let id: Int
    let day: String

    func makeContentView() -> UIView & UIContentView {
        WeekDaysContentView(with: self)
    }

    func updated(for state: UIConfigurationState) -> WeekDayConfiguration {
        return self
    }
}


