//
//  UIFont.swift
//  Gismart Test Task
//
//  Created by Igor on 10/07/2022.
//

import UIKit

extension UIFont {
    
    static func semibold(fontSize: Int) -> UIFont? {
        return UIFont.systemFont(ofSize: CGFloat(fontSize), weight: .semibold)
    }
    
    static func black(fontSize: Int) -> UIFont? {
        return UIFont.systemFont(ofSize: CGFloat(fontSize), weight: .black)
    }
    
    static func regular(fontSize: Int) -> UIFont? {
        return UIFont.systemFont(ofSize: CGFloat(fontSize), weight: .regular)
    }
    
}
