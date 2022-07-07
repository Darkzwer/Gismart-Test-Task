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
    @IBOutlet weak var LAST: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var OFF: UILabel!
    
    //MARK: - Vars
    //var seconds:Int = 0//первый таймер
    var timer = Timer()
    
    //MARK: - @IBAction
    @IBAction func showPopUp(_ sender: UIButton) {
        timer.invalidate()
    }
    
    //MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        startTimer()
        //gradientButtonOld()
        gradientButtonNew()
        animateText()
        timerSetup()
        timeTextView.alpha = 0
        timeTextView.text = "00:24:00:00"
        view.backgroundColor = .black
        popUpOutlet.applyGradient(colours: [.systemIndigo, .systemPink])
        LAST.font = UIFont.systemFont(ofSize: 35, weight: .semibold)
        
        //Observers
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(myObserverMethod),
                                               name:UIApplication.didEnterBackgroundNotification, object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(applicationWillEnterForeground),
                                               name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    //MARK: - SetupNewGradientButtonNEW
    func gradientButtonNew () {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [
            UIColor.systemPink.cgColor,
            UIColor.systemBlue.cgColor,
        ]
        popUpOutlet.setTitle("ACTIVATE OFFER", for: .normal)
        popUpOutlet.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
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
        guard let sec = segue.destination as? PopUpVC else { return }
        sec.secFromVC = secondsLabel.text
        guard let min = segue.destination as? PopUpVC else { return }
        min.minFromVC = minutesLabel.text
        guard let hour = segue.destination as? PopUpVC else { return }
        hour.hourFromVC = hoursLabel.text
        guard let day = segue.destination as? PopUpVC else { return }
        day.daysFromVC = daysLabel.text
    }
    
    //MARK: - FadeAnimation
    func animateText () {
        UIView.animate(withDuration: 1.0, animations: {
            self.OFF.alpha = 1.0
        }, completion: {
            (completed : Bool) -> Void in
            UIView.animate(withDuration: 1.0, delay: 3.0,
                           options: UIView.AnimationOptions.curveLinear,
                           animations: {
                self.OFF.alpha = 0
            }, completion: {
                (completed : Bool) -> Void in
                self.animateText()
            })
        })
    }
    
    
    //MARK: - Start & Pause
    @objc func myObserverMethod() {
        pauseTimer()
    }
    @objc func applicationWillEnterForeground(notification: Notification) {
        startTimer()
    }
    
    
    //MARK: - TimerLookSetup
    func timerSetup() {
        secondsLabel.fadeTransition(0.8)
        secondsLabel.font = UIFont.boldSystemFont(ofSize: 20)
        secondsLabel.clipsToBounds = true
        secondsLabel.layer.cornerRadius = 12
        minutesLabel.fadeTransition(1)
        minutesLabel.font = UIFont.boldSystemFont(ofSize: 20)
        minutesLabel.clipsToBounds = true
        minutesLabel.layer.cornerRadius = 12
        hoursLabel.fadeTransition(1)
        hoursLabel.font = UIFont.boldSystemFont(ofSize: 20)
        hoursLabel.clipsToBounds = true
        hoursLabel.layer.cornerRadius = 12
        daysLabel.fadeTransition(1)
        daysLabel.font = UIFont.boldSystemFont(ofSize: 20)
        daysLabel.clipsToBounds = true
        daysLabel.layer.cornerRadius = 12
        stackView.backgroundColor = nil
        
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
    
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
}
