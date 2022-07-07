//
//  Alerts.swift
//  Gismart Test Task
//
//  Created by Igor on 07/07/2022.
//

import UIKit

struct Alerts {
    
    static func showBasicAlert(title: String, message: String, on vc: UIViewController) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let dismiss = UIAlertAction(title: "Dismiss", style: .cancel)
        
        alert.addAction(dismiss)
        
        vc.present(alert, animated: true)
        
    }
    
}
