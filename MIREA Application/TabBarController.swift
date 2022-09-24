//
//  TabBarControllerViewController.swift
//  Mirea App
//
//  Created by Кирилл Пигалкин on 03.08.2022.
//

import UIKit
import AudioToolbox

final class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupColor()
        setupTabBar()
    }
   
    func setupTabBar() {
        print("⭕️ setupTabBar in TabBarController")
        let navCNews = NavigationController(rootViewController: NewsViewController())
        let navCSchedule = NavigationController(rootViewController: ScheduleViewController())
        let navCMap = NavigationController(rootViewController: MapViewController())

        navCNews.tabBarItem = UITabBarItem(
            title: "Новости",
            image: UIImage(systemName: "lineweight"),
            tag: 0)
    
        navCSchedule.tabBarItem = UITabBarItem(
            title: "Раписание",
            image: UIImage(systemName: "graduationcap.fill"),
            tag: 1)
        
        navCMap.tabBarItem = UITabBarItem(
            title: "Схема",
            image: UIImage(systemName: "map.fill"),
            tag: 2)
        
        setViewControllers(
            [navCNews, navCSchedule, navCMap],
            animated: false)
    }
}

extension TabBarController {
        // Animate TabBarItems
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        UIImpactFeedbackGenerator(style: .medium).impactOccurred(intensity: 0.65) /// Vibrating
        guard let barItemView = item.value(forKey: "view") as? UIView else { return }
        let timeInterval: TimeInterval = 1.0
        let propertyAnimator = UIViewPropertyAnimator(duration: timeInterval, dampingRatio: 0.5) {
            barItemView.transform = CGAffineTransform.identity.scaledBy(x: 0.6, y: 0.6)
        }
        propertyAnimator.addAnimations({ barItemView.transform = .identity }, delayFactor: CGFloat(timeInterval))
        propertyAnimator.startAnimation()
    }
    
    private func setupColor() {
        let blur = Color.makeBlurEffect()
        blur.frame = tabBar.bounds
        tabBar.addSubview(blur)
        
        let appearance = UITabBarAppearance()
        appearance.stackedItemPositioning = .centered
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = Color.defaultTheme.lightBlack.withAlphaComponent(0.3)
        
        UITabBar.appearance().scrollEdgeAppearance = appearance
        UITabBar.appearance().standardAppearance = appearance
        setTabBarItemColors(appearance.stackedLayoutAppearance)
        setTabBarItemColors(appearance.inlineLayoutAppearance)
        setTabBarItemColors(appearance.compactInlineLayoutAppearance)
    }
    
    private func setTabBarItemColors(_ itemAppearance: UITabBarItemAppearance) {
        itemAppearance.normal.iconColor = UIColor.lightGray
        itemAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.gray]
        itemAppearance.selected.iconColor = .white
        itemAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
}
