//
//  CalendarHelper.swift
//  MIREA Application
//
//  Created by Кирилл Пигалкин on 29.08.2022.
//

import Foundation
import UIKit

class CalendarHelper {
    static let calendar = Calendar.current

    
    static func plusMonth(date: Date) -> Date {
        return calendar.date(byAdding: .month, value: 1, to: date)!
    }
    
    static func minusMonth(date: Date) -> Date {
        return calendar.date(byAdding: .month, value: -1, to: date)!
    }
    
    static func monthString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        return dateFormatter.string(from: date)
    }
    
    static func monthStringNumber(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM"
        return dateFormatter.string(from: date)
    }
    
    static func yearString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        return dateFormatter.string(from: date)
    }
    
    static func daysInMonth(date: Date) -> Int {
        let range = calendar.range(of: .day, in: .month, for: date)!
        return range.count
    }
    
    static func dayOfMonth(date: Date) -> Int {
        let components = calendar.dateComponents([.day], from: date)
        return components.day!
    }
    
    static func firstOfMonth(date: Date) -> Date {
        let components = calendar.dateComponents([.year, .month], from: date)
        return calendar.date(from: components)!
    }
    
    static func weekDay(date: Date) -> Int {
        let components = calendar.dateComponents([.weekday], from: date)
        return components.weekday! - 1
    }
    
    static func dropMonth(date: Date, monthNumber: String) -> Date {
        var newDate = date

        while monthStringNumber(date: newDate) != monthNumber {
            newDate = minusMonth(date: newDate)
        }
        return newDate
    }
   
    static func weekAdjustment(previousMonthDays: Int, currentMonthDays: Int) -> Int {
        let monthDays = 42 - (previousMonthDays - 1) - currentMonthDays
        let weekAdjustment = (monthDays - 1) / 7 + 1
        return weekAdjustment
    }
    
    static func makeDateMarks(date: Date) -> (currentMonthStringNumber: String, daysInPreviousMonth: Int, daysInMonth: Int, startSpace: Int) {

        let currentMonth = CalendarHelper.monthStringNumber(date: date)
        let daysInPreviousMonth = CalendarHelper.daysInMonth(date: CalendarHelper.minusMonth(date: date))
        let daysInMonth = CalendarHelper.daysInMonth(date: date)
        let firstDayOfMonth = CalendarHelper.firstOfMonth(date: date)
        let space = CalendarHelper.weekDay(date: firstDayOfMonth)
        
        let tuple = (currentMonthStringNumber: currentMonth, daysInPreviousMonth: daysInPreviousMonth, daysInMonth: daysInMonth, startSpace: space)
        return tuple
    }
    
    static func getCurrentDate() -> Date {
        return Date()
    }
    static func getWeekDay(month: String?, day: Int?) -> Int {
    
        // Specify date components
        var dateComponents = DateComponents()
        dateComponents.year = calendar.dateComponents([.year], from: .now).year
        dateComponents.month = Int(month ?? "02")
        dateComponents.day = day
        dateComponents.hour = 12
        
        // Create date from components
        let calendar = Calendar(identifier: .gregorian)
        let newDate = calendar.date(from: dateComponents)
        var weekDay = calendar.dateComponents([.weekday], from: newDate ?? .now).weekday! - 1
        if weekDay == 0 { weekDay = 7 } // idk why sunday is 0
        
        return weekDay
    }
    
    
}
