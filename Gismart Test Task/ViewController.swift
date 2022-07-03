//
//  ViewController.swift
//  Gismart Test Task
//
//  Created by Igor on 29.06.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var OfferButton: UIButton!
    @IBAction func showPopUp(_ sender: UIButton) {
        
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "sbPopUpID") as! PopUpVC
        self.addChild(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParent: self)
    }
    
    let timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let button = GradientButton(colors : [UIColor.systemPurple.cgColor, UIColor.systemPink.cgColor])
        button.frame = CGRect (x: 95, y: 20, width: 403, height: 88)
        view.addSubview(button)
        //button.center = view.center
        button.setTitle("ACTIVATE OFFER", for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 12
    }
    
    
}

