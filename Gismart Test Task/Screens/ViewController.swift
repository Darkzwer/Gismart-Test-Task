//
//  ViewController.swift
//  Gismart Test Task
//
//  Created by Igor on 29.06.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var timeTextView: UILabel!
    
    var seconds:Int = 0
    var timer = Timer()
    var hasStarted = false
    
    @IBOutlet weak var popUpOutlet: UIButton!
    @IBAction func showPopUp(_ sender: UIButton) {
        openPopOverVC()
        timer.invalidate()
    }
    
    //MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        startTimer()
        gradientButtonOld()
        gradientButtonNew()
        view.backgroundColor = .black
    }
    
    func gradientButtonNew () {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [
            UIColor.systemPink.cgColor,
            UIColor.systemBlue.cgColor,
        ]
        //popUpOutlet.self = gradientLayer
        popUpOutlet.center = view.center
        popUpOutlet.setTitle("ACTIVATE", for: .normal)
        popUpOutlet.clipsToBounds = true
        popUpOutlet.layer.cornerRadius = 12
    }
    
    //MARK: - SetupGradientButton
    func gradientButtonOld () {
        let button = GradientButton(colors : [UIColor.systemPurple.cgColor, UIColor.systemPink.cgColor])
        button.frame = CGRect (x: 95, y: 20, width: 403, height: 88)
        view.addSubview(button)
        //button.center = view.center
        button.setTitle("ACTIVATE OFFER", for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 12
    }
    
    //MARK: - PrepareForSegue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.destination is PopUpVC else { return }
    }
    
    
    //MARK: - PopScreen
    func openPopOverVC () {
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "sbPopUpID") as! PopUpVC
        self.addChild(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParent: self)
    }
    
    //MARK: - Animation
    private func animateTimer() {
        
    }
    
    
}

