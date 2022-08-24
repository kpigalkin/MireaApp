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
        
        // Making navBar is Opaque
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = Colors.defaultTheme.sand
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
            UINavigationBar.appearance().compactScrollEdgeAppearance = appearance
            UINavigationBar.appearance().compactAppearance = appearance
        }
    }
}
