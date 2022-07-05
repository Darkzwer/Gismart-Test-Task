//
//  ViewController.swift
//  Gismart Test Task
//
//  Created by Igor on 29.06.2022.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - @IBOutlet
    @IBOutlet weak var timeTextView: UILabel!
    
    @IBOutlet weak var daysLabel: UILabel!
    @IBOutlet weak var hoursLabel: UILabel!
    @IBOutlet weak var minutesLabel: UILabel!
    @IBOutlet weak var secondsLabel: UILabel!
    
    @IBOutlet weak var popUpOutlet: UIButton!
    
    @IBOutlet weak var segueoutlet: UILabel!
    
    //MARK: - Vars
    //var seconds:Int = 0//первый таймер
    var (days, hours, minutes, seconds) = (0,0,0,0)//второй таймер
    
    var timer = Timer()
    var hasStarted = false
    
    //MARK: - @IBAction
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
        //startTimer2()
    }
    
    //MARK: - SetupNewGradientButton
    func gradientButtonNew () {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [
            UIColor.systemPink.cgColor,
            UIColor.systemBlue.cgColor,
        ]
        //popUpOutlet.self = gradientLayer
        //popUpOutlet.center = view.center
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
        guard let transportData = segue.destination as? PopUpVC else { return }
        transportData.secFromVC = timeTextView.text
    }
    
    
    //MARK: - PopScreenOpen
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
    
    //MARK: - Conventor
    func secondsToTime(for seconds: Int) -> String {
        var eSeconds = seconds
        var minutes = 0
        var hours = 0
        var days = 0// мой код
        
        if seconds < 60 {
            return seconds < 10 ? "00:00:00:0\(seconds)" : "00:00:00:\(seconds)"
        } else if seconds == 60 {
            return "00:00:01:00"
        } else {
            //all other logic goes here...
            
            while eSeconds >= 60 {
                minutes += 1
                eSeconds -= 60
            }
            
            while minutes >= 60 {//мой код
                hours += 1
                minutes -= 60
            }
            
            while hours >= 24 {
                days += 1
                hours -= 24
                
                if days == 30 {
                    return "30:00:00:00"
                }
            }
            
            let daysString = days < 10 ? "0\(days)" : "\(days)"
            let hourString = hours < 10 ? "0\(hours)" : "\(hours)"
            let minuteString = minutes < 10 ? "0\(minutes)" : "\(minutes)"
            let secondString = eSeconds < 10 ? "0\(eSeconds)" : "\(eSeconds)"
            
            daysLabel.text = daysString
            hoursLabel.text = hourString
            minutesLabel.text = minuteString
            secondsLabel.text = secondString
            
            return "\(daysString):\(hourString):\(minuteString):\(secondString)"
        }
        
    }

    enum TMError: Error {
        case err
    }

    //conventer
    func timeToSeconds(for time: String) throws -> Int {
        
        let metrics = time.split(separator: ":")
        
        guard let days = Int(metrics[0]) else { throw TMError.err }//мой код
        guard let hours = Int(metrics[1]) else { throw TMError.err }//есть модификации
        guard let minutes = Int(metrics[2]) else { throw TMError.err }//есть модификации
        guard let seconds = Int(metrics[3]) else { throw TMError.err }//есть модификации
        
        return days*86400 + hours*3600 + minutes*60 + seconds
    }
    
    
}

