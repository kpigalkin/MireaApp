//
//  Models.swift
//  MIREA Application
//
//  Created by Кирилл Пигалкин on 29.09.2022.
//

import UIKit

struct NewsItem: Decodable {
    let id: Int
    let name: String
    let image: String
}
typealias NewsItems = [NewsItem]
