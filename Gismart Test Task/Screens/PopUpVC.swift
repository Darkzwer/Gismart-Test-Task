//
//  PopUpVC.swift
//  Gismart Test Task
//
//  Created by Igor on 03/07/2022.
//

import UIKit

class PopUpVC: UIViewController {
    
    @IBOutlet weak var popUpView: UIView!
    @IBOutlet weak var popUpLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        view.layer.cornerRadius = 30
        
        //let flipingCard = UIView.AnimationTransition(rawValue: mypa)
        
        let offerDay = "00"
        let offerMinute = "03"
        let offerSecunde = "05"
        popUpLabel.text = ("Offer activated at " + "\(offerMinute)" + "\(":")" + "\(offerSecunde)" + "\(":")" + "\(offerDay)" + "\(":")")
        popUpView.layer.cornerRadius = 25
        popUpLabel.backgroundColor = nil
        popUpLabel.textColor = .white
    }
    
    
}
