//
//  StartTimer2.swift
//  Gismart Test Task
//
//  Created by Igor on 05/07/2022.
//

import UIKit

extension ViewController {
    
    func startTimer2() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.keepTimer), userInfo: nil, repeats: true)
    }
    
    @objc func keepTimer() {
        
        timeTextView.text = "00:24:00:00"
        seconds += 1
        if seconds > 60 {
            minutes += 1
            seconds = 0
        }
        
        if minutes == 60 {
            hours += 1
            minutes = 0
        }
        
        if hours == 24 {
            days += 1
            hours = 0
        }
        
        //daysLabel.text = ":\(days)"
        //hoursLabel.text = ":\(hours)"
        //minutesLabel.text = ":\(minutes)"
        
        //timeTextView.text = ":\(hours):\(minutes):\(seconds)"
        //secondsLabel.text = ":\(seconds)"
    }
    
    
}
