//
//  PopUpVC.swift
//  Gismart Test Task
//
//  Created by Igor on 03/07/2022.
//

import UIKit

class PopUpVC: UIViewController {
    
    var secFromVC: String?//take data from 1VC
    var minFromVC: String?
    var hourFromVC: String?
    var daysFromVC: String?
    
    @IBOutlet weak var popUpView: UIView!
    @IBOutlet weak var popUpLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        
        popUpSetup()
        
        guard let secFromVC = self.secFromVC else { return }//removes optional label
        guard let minFromVC = self.minFromVC else { return }
        guard let hourFromVC = self.hourFromVC else { return }
        guard let daysFromVC = self.daysFromVC else { return }
        
        if daysFromVC == "00" {
            print("Label is nil")
        }
        popUpLabel.text = "Offer activated at \(secFromVC)"//сетит даные в лейбл из первого контроллера
        popUpLabel.text = ("Offer activated at " + "\(daysFromVC)" + "\(":")" + "\(hourFromVC)" + "\(":")" + "\(minFromVC)" + "\(":")" + "\(secFromVC)")
    }
    
    func popUpSetup () {
        popUpView.layer.cornerRadius = 25
        popUpLabel.backgroundColor = nil
        popUpLabel.textColor = .white
    }
}
