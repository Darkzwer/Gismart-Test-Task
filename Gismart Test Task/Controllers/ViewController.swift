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
    @IBOutlet weak var trueMusicFans: UILabel!
    @IBOutlet weak var hundreOfSongs: UILabel!
    @IBOutlet weak var PRT: UILabel!
    
    //MARK: - Vars
    //var seconds:Int = 0
    var timer = Timer()
    
    //MARK: - @IBAction
    @IBAction func showPopUp(_ sender: UIButton) {
        
        timer.invalidate()
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "sbPopUpID") as! PopUpVC
        popOverVC.didMove(toParent: self)
        popOverVC.secFromVC = secondsLabel.text
        popOverVC.minFromVC = minutesLabel.text
        popOverVC.hourFromVC = hoursLabel.text
        popOverVC.daysFromVC = daysLabel.text
        self.addChild(popOverVC)
        popOverVC.didMove(toParent: self)
        popOverVC.view.frame = self.view.frame
        popOverVC.didMove(toParent: self)
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParent: self)
    }
    
    //MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        view.pushTransition(1.8)
        startTimer()
        //gradientButtonOld()
        gradientButtonNew()
        animateText()
        timerSetup()
        timeTextView.alpha = 0
        timeTextView.text = "00:24:00:00"
        setupAnimation()
        popUpOutlet.applyGradient(colours: [.systemIndigo, .systemPink])
        LAST.font = UIFont.semibold(fontSize: 35)
        OFF.font = UIFont.black(fontSize: 55)
        trueMusicFans.font = UIFont.semibold(fontSize: 15)
        pauseStartObservers()
        fontSize()
        
    }
    
    //MARK: - SetupGradientButton
    func gradientButtonOld () {
        let button = GradientButton(colors : [UIColor.systemPurple.cgColor, UIColor.systemPink.cgColor])
        button.frame = CGRect (x: 95, y: 20, width: 403, height: 88)
        view.addSubview(button)
        button.setTitle("ACTIVATE OFFER", for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 12
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
    
    func setupAnimation() {
        daysLabel.pushTransition(0.5)
        minutesLabel.pushTransition(0.5)
        hoursLabel.pushTransition(0.5)
    }
    
    //MARK: - Start & Pause
    @objc func myObserverMethod() {
        pauseTimer()
    }
    @objc func applicationWillEnterForeground(notification: Notification) {
        startTimer()
    }
    
    func fontSize () {
        if UIScreen.main.bounds.size.height >= 820 {
            // iPad
            LAST.font = UIFont.semibold(fontSize: 35)
            OFF.font = UIFont.black(fontSize: 80)
            trueMusicFans.font = UIFont.semibold(fontSize: 20)
            popUpOutlet.translatesAutoresizingMaskIntoConstraints = false
            popUpOutlet.frame.size = CGSize(width: 403.0, height: 88.0)
            
        }
    }
    
    //MARK: - TimerLookSetup
    func timerSetup() {
        secondsLabel.pushTransition(0.4)
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
        var days = 0
        
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
            
            while minutes >= 60 {
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
            
            secondsLabel.pushTransition(0.4)
            
            minutesLabel.fadeTransition(0.4)
            hoursLabel.fadeTransition(0.4)
            daysLabel.fadeTransition(0.4)
            
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
    
    func timeToSeconds(for time: String) throws -> Int {
        
        let metrics = time.split(separator: ":")
        
        guard let days = Int(metrics[0]) else { throw TMError.err }
        guard let hours = Int(metrics[1]) else { throw TMError.err }
        guard let minutes = Int(metrics[2]) else { throw TMError.err }
        guard let seconds = Int(metrics[3]) else { throw TMError.err }
        
        return days*86400 + hours*3600 + minutes*60 + seconds
    }
    
    //MARK: - Observers
    func pauseStartObservers () {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(myObserverMethod),
                                               name:UIApplication.didEnterBackgroundNotification, object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(applicationWillEnterForeground),
                                               name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    
}
