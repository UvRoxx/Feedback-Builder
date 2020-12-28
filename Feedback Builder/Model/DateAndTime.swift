//
//  DateAndTime.swift
//  Feedback Builder
//
//  Created by UTKARSH VARMA on 2020-12-22.
//

import Foundation
import CoreData
struct DateAndTime{
    let date = Date()
    let calendar = Calendar.current
    let senderSettingsBrain = SenderSettingsBrain()
    func getDisplayDate()->String{
        
        let monthComponents = Calendar.current.shortMonthSymbols
        let monthNum = calendar.component(.month, from: date)
        let dayNum = Calendar.current.component(.weekday, from: Date())
        let dayComponents = Calendar.current.shortWeekdaySymbols
         return "\(dayComponents[dayNum-1]) \(calendar.component(.day, from: date)) \(monthComponents[monthNum-1]) \(calendar.component(.year, from: date))"
        
    }
    
    func getGreeting()->String{
        var greeting = ""
       let hour = calendar.component(.hour, from: date)
        if hour >= 5 && hour <= 12{
            greeting = "Good Morning"
        }else if hour > 12 && hour <= 5{
            greeting = "Good Afternoon"
            
        }else{
            greeting = "Good Evening"
        }
        
        let userName = senderSettingsBrain.getUserName()
        let firstName = userName.components(separatedBy: " ")
        greeting = "\(greeting)\n\(firstName[0])"
    return greeting
        
    }
    
}
