//
//  TimerVC+Ext.swift
//  Gismart Test Task
//
//  Created by Igor on 04/07/2022.
//

import UIKit

//этот код не вызывается на старте а срабатывает при нажатии кнопок
extension ViewController {
    func pauseTimer() {
        timer.invalidate()
        startButton.setTitle("RUN", for: .normal)
        
        hasStarted = false
    }
    
    func startTimer() {
        guard let timerInfo = timeTextView.text else {
            //Alerts.showBasicAlert(title: "Error!", message: "There was some kind of error when trying to countdown.", on: self)
            return
        }
        
        do {
            seconds = try timeToSeconds(for: timerInfo)
        } catch {
            //Alerts.showBasicAlert(title: "Invalid time format", message: "Please make sure you enter a valid time in the textiview. Start with hours, then minutes followed by seconds. For example, 1 hour 54 minutes and 23 seconds should b entered as- 1:54:23", on: self)
        }
        
        guard seconds > 0 else {
            
            //Alerts.showBasicAlert(title: "Invalid time format", message: "Please make sure you enter a valid time in the textview, other than 00:00:00:00.", on: self)
            
            return
        }
        
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(count), userInfo: nil, repeats: true)
        
        startButton.setTitle("PAUSE", for: .normal)
        hasStarted = true
    }
    
    @objc func count() {
        seconds -= 1
        timeTextView.text = secondsToTime(for: seconds)
        
        if timeTextView.text == "99:00:00:00" || timeTextView.text == "00:00:00:00" {
            //Alerts.showBasicAlert(title: "Timer has finished!", message: "The timer has finished counting down from the specified time period.", on: self)
        }
        
    }
    
    
}
