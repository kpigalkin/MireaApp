//
//  Extensions.swift
//  MIREA Application
//
//  Created by Кирилл Пигалкин on 18.09.2022.
//

import Foundation
import UIKit

// MARK: - UIColor extension for hex-form colors

extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}

// MARK: - Animate tabBar hiding
extension UIViewController {
    func showTabBar() {
        guard var frame = tabBarController?.tabBar.frame else { return }
        guard frame.origin.y == view.frame.size.height else { return }
        frame.origin.y = view.frame.size.height - frame.size.height
        UIView.animate(withDuration: 0.15) { self.tabBarController?.tabBar.frame = frame }
    }
    
    func hideTabBar() {
        guard var frame = tabBarController?.tabBar.frame else { return }
        frame.origin.y = view.frame.size.height
        UIView.animate(withDuration: 0.25) { self.tabBarController?.tabBar.frame = frame }
    }
}
