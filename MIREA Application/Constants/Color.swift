//
//  Color.swift
//  MIREA Application
//
//  Created by kpigalkin on 30.09.2022.
//

import UIKit

enum Color {
    struct defaultDark {
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
    
    // MARK: Class type color
    
    static let lection = UIColor.lightGray
    static let practice = Color.defaultDark.red.withAlphaComponent(0.93)
    static let labaratory = Color.defaultDark.orange
    static let defaultColor = UIColor.black
}
