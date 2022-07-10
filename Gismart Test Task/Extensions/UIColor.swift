//
//  UIColor.swift
//  Gismart Test Task
//
//  Created by Igor on 10/07/2022.
//

import UIKit

extension UIColor {
    static var yourColor:UIColor {
        return UIColor(red: 0.745, green: 0.157, blue: 0.074, alpha: 1)
    }
}

extension UIView {
    enum GlowEffect: Float {
        case small = 0.4, normal = 2, big = 30
    }

    func doGlowAnimation(withColor color: UIColor, withEffect effect: GlowEffect = .normal) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowRadius = 0
        layer.shadowOpacity = 1
        layer.shadowOffset = .zero

        let glowAnimation = CABasicAnimation(keyPath: "shadowRadius")
        glowAnimation.fromValue = 20 // effect.rawValue
        glowAnimation.toValue = 20
        glowAnimation.fillMode = .removed
        glowAnimation.repeatCount = .infinity
        layer.add(glowAnimation, forKey: "shadowGlowingAnimation")
    }
}
