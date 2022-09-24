//
//  DesignElements.swift
//  MIREA Application
//
//  Created by Кирилл Пигалкин on 21.08.2022.
//

import Foundation
import UIKit

enum Const {
    static let minSpace: CGFloat = 5
    static let space: CGFloat = 10
    static let middleSpace: CGFloat = 20
    static let longSpace: CGFloat = 40
    
    static let lowSizeCorner: CGFloat = 10
    static let midSizeCorner: CGFloat = 17
    static let highSizeCorner: CGFloat = 20
}

enum UDKeys {
    static let id = "id"
    static let name = "name"
}

enum Color {
    struct defaultTheme {
        static let dirtyWhite = UIColor(hexString: "#f3f3f3")
        static let lightBlack = UIColor(hexString: "#383c3f")
        static let lightBlue = UIColor(hexString: "#222629")
        static let red = UIColor(hexString: "#dd3838")
        static let black = UIColor(hexString: "#222222")
        static let orange = UIColor(hexString: "#F57F17")
        
        static let lightText = UIColor(hexString: "#eceded")
    }
    
    static func makeBlurEffect() -> UIVisualEffectView {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return blurEffectView
    }
}
