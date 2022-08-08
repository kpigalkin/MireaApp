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

        tabBar.isOpaque = false
        tabBar.tintColor = .black
        tabBar.unselectedItemTintColor = .lightGray
        tabBar.backgroundColor = .blue
        setupTabBar()
    }
}
 
private extension TabBarController {
    
    func setupTabBar() {
        print("⭕️ setupTabBar in TabBarController")
        
        let newsVC = NewsViewController()
        let scheduleVC = ScheduleViewController()
        let mapVC = MapViewController()
        
        let navCNews = NavigationController(rootViewController: newsVC)
        let navCSchedule = NavigationController(rootViewController: scheduleVC)
        let navCMap = NavigationController(rootViewController: mapVC)
        
//        let configuration = UIImage.SymbolConfiguration(pointSize: 23, weight: .heavy)
            
        navCNews.tabBarItem = UITabBarItem(
            title: "Новости",
            image: UIImage(systemName: "newspaper"),
            tag: 0)
//        navCNews.tabBarItem.selectedImage = UIImage(systemName: "newspaper.fill",withConfiguration: configuration)
        
        navCSchedule.tabBarItem = UITabBarItem(
            title: "Расписание",
            image: UIImage(systemName: "calendar"),
            tag: 1)
//        navCSchedule.tabBarItem.selectedImage = UIImage(systemName: "calendar.fill", withConfiguration: configuration)
        
        navCMap.tabBarItem = UITabBarItem(
            title: "Карта",
            image: UIImage(systemName: "map"),
            tag: 2)
//        navCMap.tabBarItem.selectedImage = UIImage(systemName: "map.fill", withConfiguration: configuration)
        
        setViewControllers(
            [navCNews, navCSchedule, navCMap],
            animated: false)
    }
}
