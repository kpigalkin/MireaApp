//
//  NewsConfig.swift
//  MIREA Application
//
//  Created by Кирилл Пигалкин on 25.08.2022.
//

import UIKit

struct NewsConfiguration: UIContentConfiguration {

    let id: Int
    let name: String
    let imageUrl: URL
    var image: UIImage?

    func makeContentView() -> UIView & UIContentView {
        NewsContentView(with: self)
    }

    func updated(for state: UIConfigurationState) -> NewsConfiguration {
        return self
    }
}
