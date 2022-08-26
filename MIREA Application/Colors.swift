//
//  DesignElements.swift
//  MIREA Application
//
//  Created by Кирилл Пигалкин on 21.08.2022.
//

import Foundation
import UIKit

enum Colors {
    struct secondTheme {
        static let clearWhite = UIColor(hexString: "#ffffff")
        static let black = UIColor(hexString: "#000000")
        static let darkBlue = UIColor(hexString: "#2f4550")
        static let grayBlue = UIColor(hexString: "#586f7c")
        static let skyBlue = UIColor(hexString: "#b8dbd9")
        static let dirtyWhite = UIColor(hexString: "#f4f4f9")
    }
    
    struct defaultTheme {
        static let dirtyWhite = UIColor(hexString: "#f3f3f3")
        static let darkBlue = UIColor(hexString: "#2F3B50")
        static let sand = UIColor(hexString: "#CFB78B")
        static let red = UIColor(hexString: "#dd3838")
        static let black = UIColor(hexString: "#222222")

    }
    func setGradientBackground(view: UIView) {
        let colorTop = Colors.defaultTheme.sand.cgColor
        let colorBottom = Colors.defaultTheme.darkBlue.cgColor
                    
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = view.bounds
                
        view.layer.insertSublayer(gradientLayer, at:0)
    }
            
}

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
