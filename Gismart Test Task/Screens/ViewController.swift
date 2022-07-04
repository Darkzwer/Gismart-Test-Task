//
//  ViewController.swift
//  Gismart Test Task
//
//  Created by Igor on 29.06.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var timeTextView: UILabel!
    @IBOutlet weak var startButton: UIButton!
    
    var seconds:Int = 0
    var timer = Timer()
    var hasStarted = false
    
    @IBAction func startTimer(_ sender: UIButton) {
        if hasStarted { pauseTimer() }
        else { startTimer() }
    }
    
    @IBOutlet weak var popUpOutlet: UIButton!
    @IBAction func showPopUp(_ sender: UIButton) {
        openPopOverVC()
        timer.invalidate()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startTimer()
        gradientButtonOld()
        gradientButtonNew()
        view.backgroundColor = .black
    }
    
    func gradientButtonNew () {
        let gradientLook = GradientButton(colors : [UIColor.systemPurple.cgColor, UIColor.systemPink.cgColor])
        //popUpOutlet = gradientLook
        popUpOutlet.center = view.center
        popUpOutlet.setTitle("ACTIVATE", for: .normal)
        popUpOutlet.clipsToBounds = true
        popUpOutlet.layer.cornerRadius = 12
    }
    
    func gradientButtonOld () {
        let button = GradientButton(colors : [UIColor.systemPurple.cgColor, UIColor.systemPink.cgColor])
        button.frame = CGRect (x: 95, y: 20, width: 403, height: 88)
        view.addSubview(button)
        //button.center = view.center
        button.setTitle("ACTIVATE OFFER", for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 12
    }
    
    func openPopOverVC () {
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "sbPopUpID") as! PopUpVC
        self.addChild(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParent: self)
    }
    
    
}

