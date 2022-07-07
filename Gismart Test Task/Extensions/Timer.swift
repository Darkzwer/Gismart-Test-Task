//
//  TimerVC+Ext.swift
//  Gismart Test Task
//
//  Created by Igor on 04/07/2022.
//

import UIKit

extension ViewController {
    
    func pauseTimer() {
        timer.invalidate()
        hasStarted = false
    }
    
    func startTimer() {
        
        guard let timerInfo = timeTextView.text else { return }
        
        do {
            AppConstans.seconds = try timeToSeconds(for: timerInfo)
        } catch {
            Alerts.showBasicAlert(title: "Invalid time format", message: "Please make sure you enter a valid time in the textiview. Start with hours, then minutes followed by seconds. For example, 1 hour 54 minutes and 23 seconds should b entered as- 1:54:23", on: self)
        }
        
        guard AppConstans.seconds > 0 else { return }
        
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(count), userInfo: nil, repeats: true)
        
        hasStarted = true
        
        //secondsLabel.isEditable = false
        
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(count), userInfo: nil, repeats: true)
        
        hasStarted = true
    }
    
    @objc func count() {
        AppConstans.seconds -= 1
        timeTextView.text = secondsToTime(for: AppConstans.seconds)//пишет результат в лейбл
        
        if timeTextView.text == "99:00:00:00" || timeTextView.text == "00:00:00:00" {
            timer.invalidate()
            Alerts.showBasicAlert(title: "Timer has finished!", message: "The timer has finished counting down from the specified time period.", on: self)
        }
        
    }
    
    
}
