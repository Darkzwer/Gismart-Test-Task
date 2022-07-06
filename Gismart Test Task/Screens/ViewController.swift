//
//  ViewController.swift
//  Gismart Test Task
//
//  Created by Igor on 29.06.2022.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - @IBOutlet
    @IBOutlet weak var timeTextView: UILabel!//mainTimerOld
    @IBOutlet weak var daysLabel: UILabel!
    @IBOutlet weak var hoursLabel: UILabel!
    @IBOutlet weak var minutesLabel: UILabel!
    @IBOutlet weak var secondsLabel: UILabel!
    @IBOutlet weak var popUpOutlet: UIButton!//Button to 2 vc
    
    //MARK: - Vars
    //var seconds:Int = 0//первый таймер
    var (days, hours, minutes, seconds) = (0,0,0,0)//второй таймер
    var timer = Timer()
    var hasStarted = false
    
    //MARK: - @IBAction
    @IBAction func showPopUp(_ sender: UIButton) {
        timer.invalidate()
    }
    
    //MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        startTimer()
        gradientButtonOld()
        gradientButtonNew()
        view.backgroundColor = .black
        timeTextView.alpha = 0
        animateText()
        timerSetup()
        timeTextView.text = "00:20:00:00"
        
    }
    
    //MARK: - SetupNewGradientButton
    func gradientButtonNew () {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [
            UIColor.systemPink.cgColor,
            UIColor.systemBlue.cgColor,
        ]
        popUpOutlet.setTitle("ACTIVATE OFFER", for: .normal)
        popUpOutlet.clipsToBounds = true
        popUpOutlet.layer.cornerRadius = 12
        //popUpOutletfont = UIFont.semi
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
        guard let transportData1 = segue.destination as? PopUpVC else { return }
        transportData1.secFromVC = secondsLabel.text
        guard let transportData2 = segue.destination as? PopUpVC else { return }
        transportData2.minFromVC = minutesLabel.text
        guard let transportData3 = segue.destination as? PopUpVC else { return }
        transportData3.hourFromVC = hoursLabel.text
        guard let transportData4 = segue.destination as? PopUpVC else { return }
        transportData4.daysFromVC = daysLabel.text
    }
    
    //MARK: - FadeAnimation
    func animateText () {
        UIView.animate(withDuration: 1.0, animations: {
            self.timeTextView.alpha = 1.0
        }, completion: {
            (completed : Bool) -> Void in
            UIView.animate(withDuration: 1.0, delay: 3.0,
                           options: UIView.AnimationOptions.curveLinear,
                           animations: {
                self.timeTextView.alpha = 0
            }, completion: {
                (completed : Bool) -> Void in
                self.animateText()
            })
        })
    }
    
    
    //MARK: - TimerSetup
    func timerSetup() {
        secondsLabel.fadeTransition(0.8)
        secondsLabel.font = UIFont.boldSystemFont(ofSize: 20)
        minutesLabel.fadeTransition(1)
        minutesLabel.font = UIFont.boldSystemFont(ofSize: 20)
        hoursLabel.fadeTransition(1)
        hoursLabel.font = UIFont.boldSystemFont(ofSize: 20)
        daysLabel.fadeTransition(1)
        daysLabel.font = UIFont.boldSystemFont(ofSize: 20)
        
    }
    
    //MARK: - GradientButtonSetup
    func gradientButtonSetup() {
        //popUpOutlet.
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
            
            secondsLabel.fadeTransition(1.5)
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
        
        guard let days = Int(metrics[0]) else { throw TMError.err }
        guard let hours = Int(metrics[1]) else { throw TMError.err }
        guard let minutes = Int(metrics[2]) else { throw TMError.err }
        guard let seconds = Int(metrics[3]) else { throw TMError.err }
        
        return days*86400 + hours*3600 + minutes*60 + seconds
    }
    
    
    
}

extension UIView {
    func fadeTransition(_ duration:CFTimeInterval) {
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name:
                                                            CAMediaTimingFunctionName.easeInEaseOut)
        animation.type = CATransitionType.fade
        animation.duration = duration
        layer.add(animation, forKey: CATransitionType.fade.rawValue)
    }
}
