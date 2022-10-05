//
//  Models.swift
//  MIREA Application
//
//  Created by Кирилл Пигалкин on 29.09.2022.
//

import UIKit

    // MARK: Teachers

struct TeacherItem: Decodable {
    let id: Int
    let name: String
}
typealias TeacherItems = [TeacherItem]

    // MARK: Classes

struct ClassItem: Decodable {
    let even, odd: [Subject]
}

struct Subject: Decodable {
    let name, room, type, group, strWeeks: String
    let number, wdNum: Int
    let weeks: [Int]

    private enum CodingKeys: String, CodingKey {
        case name, number
        case wdNum = "wd_num"
        case group, type, room, weeks, strWeeks
    }
}
typealias ClassItems = [[String: ClassItem]]
