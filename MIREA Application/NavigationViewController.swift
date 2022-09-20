//
//  ViewController.swift
//  Mirea App
//
//  Created by Кирилл Пигалкин on 03.08.2022.
//

import UIKit

final class NavigationController: UINavigationController {
    override func loadView() {
        super.loadView()
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .clear
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().compactScrollEdgeAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
    }
}
