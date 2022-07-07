//
//  GradientButton.swift
//  Gismart Test Task
//
//  Created by Igor on 29.06.2022.
//

import UIKit

class GradientButton: UIButton {
    
    let gradient = CAGradientLayer()
    
    init(colors: [CGColor]) {
        super.init(frame: .zero)
        gradient.frame = bounds
        gradient.colors = colors
        layer.addSublayer(gradient)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradient.frame = bounds
    }
}
