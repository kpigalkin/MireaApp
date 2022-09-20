//
//  DesignElements.swift
//  MIREA Application
//
//  Created by Кирилл Пигалкин on 21.08.2022.
//

import Foundation
import UIKit

enum Constants {
    static let minSpace: CGFloat = 5
    static let space: CGFloat = 10
    static let heightSpace: CGFloat = 20
}

enum UDKeys {
    static let id = "id"
    static let name = "name"
}

enum Colors {
    struct defaultTheme {
        static let dirtyWhite = UIColor(hexString: "#f3f3f3")
        static let lightBlack = UIColor(hexString: "#212121").withAlphaComponent(0.99)
        static let lightBlue = UIColor(hexString: "#D4D7DB")
        static let red = UIColor(hexString: "#dd3838")
        static let black = UIColor(hexString: "#222222")
        static let orange = UIColor(hexString: "#F57F17")
    }
    
    static func makeBlurEffect() -> UIVisualEffectView {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return blurEffectView
    }
}
