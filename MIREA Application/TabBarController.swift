//
//  TabBarControllerViewController.swift
//  Mirea App
//
//  Created by Кирилл Пигалкин on 03.08.2022.
//

import UIKit

final class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    // MARK: Animating tapped tabBarItem
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        guard let barItemView = item.value(forKey: "view") as? UIView else { return }
            
        let timeInterval: TimeInterval = 0.3
        let propertyAnimator = UIViewPropertyAnimator(duration: timeInterval, dampingRatio: 0.5) {
            barItemView.transform = CGAffineTransform.identity.scaledBy(x: 0.9, y: 0.9)
        }
        propertyAnimator.addAnimations({ barItemView.transform = .identity }, delayFactor: CGFloat(timeInterval))
        propertyAnimator.startAnimation()
    }
   
    func setupTabBar() {
        print("⭕️ setupTabBar in TabBarController")
        
        tabBar.isOpaque = false
        tabBar.tintColor = .white
        tabBar.unselectedItemTintColor = Colors.defaultTheme.dirtyWhite
        tabBar.layer.shadowRadius = 40
        tabBar.layer.shadowOpacity = 1.0
        tabBar.layer.shadowOffset = CGSize(width: 30, height: 20)
        tabBar.layer.shadowColor = UIColor.clear.cgColor
        
        // MARK: Setup  transparent TabBar
        if #available(iOS 15.0, *) {
            let tabBarAppearance = UITabBarAppearance()
            tabBarAppearance.backgroundColor = Colors.defaultTheme.darkBlue
            tabBarAppearance.stackedItemPositioning = .centered
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
            UITabBar.appearance().standardAppearance = tabBarAppearance
        }

        let navCNews = NavigationController(rootViewController: NewsViewController())
        let navCSchedule = NavigationController(rootViewController: ScheduleViewController())
        let navCMap = NavigationController(rootViewController: MapViewController())

        let unselectedConfiguration = UIImage.SymbolConfiguration(
            pointSize: 15, weight: .semibold)
                
        navCNews.tabBarItem = UITabBarItem(
            title: "Новости",
            image: UIImage(systemName: "newspaper", withConfiguration: unselectedConfiguration),
            tag: 0)
//
        navCSchedule.tabBarItem = UITabBarItem(
            title: "Расписание",
            image: UIImage(systemName: "calendar", withConfiguration: unselectedConfiguration),
            tag: 1)
        
        navCMap.tabBarItem = UITabBarItem(
            title: "Карта",
            image: UIImage(systemName: "map", withConfiguration: unselectedConfiguration),
            tag: 2)        
        
        setViewControllers(
            [navCNews, navCSchedule, navCMap],
            animated: false)
    }
}
