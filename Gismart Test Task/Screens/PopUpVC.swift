//
//  PopUpVC.swift
//  Gismart Test Task
//
//  Created by Igor on 03/07/2022.
//

import UIKit

class PopUpVC: UIViewController {
    
    var secFromVC: String?//переменная получающая время из первого контроллера
    var minFromVC: String?
    var hourFromVC: String?
    
    @IBOutlet weak var popUpView: UIView!
    @IBOutlet weak var popUpLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        
        popUpSetup()
        
        //guard let secFromVC = self.secFromVC else { return }//не меняет лейбл если данные не придут
        popUpLabel.text = "Hello data from first VC, \(secFromVC)"//сетит даные в лейбл из первого контроллера
        //popUpLabel.text = secFromVC
        print(secFromVC)
    }
    
    func popUpSetup () {
        popUpView.layer.cornerRadius = 25
        popUpLabel.backgroundColor = nil
        popUpLabel.textColor = .white
        print(secFromVC)
    }
}
