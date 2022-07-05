//
//  TimerConversions.swift
//  Gismart Test Task
//
//  Created by Igor on 04/07/2022.
//

import Foundation

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
        
        //добавлялка нулей
        let daysString = days < 10 ? "0\(days)" : "\(days)"//мой код
        let hourString = hours < 10 ? "0\(hours)" : "\(hours)"
        let minuteString = minutes < 10 ? "0\(minutes)" : "\(minutes)"
        let secondString = eSeconds < 10 ? "0\(eSeconds)" : "\(eSeconds)"
        
        print(minuteString)
        print(secondString)
        return "\(daysString):\(hourString):\(minuteString):\(secondString)"//добавлена строка
    }
    
}

enum TMError: Error {
    case err
}

//конвертирует полученный текст в числа
func timeToSeconds(for time: String) throws -> Int {
    
    let metrics = time.split(separator: ":")
    
    guard let days = Int(metrics[0]) else { throw TMError.err }//мой код
    guard let hours = Int(metrics[1]) else { throw TMError.err }//есть модификации
    guard let minutes = Int(metrics[2]) else { throw TMError.err }//есть модификации
    guard let seconds = Int(metrics[3]) else { throw TMError.err }//есть модификации
    
    return days*86400 + hours*3600 + minutes*60 + seconds//дописана строка про то что сколько в дне секунд
}
