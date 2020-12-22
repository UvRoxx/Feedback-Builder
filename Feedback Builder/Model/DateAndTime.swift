//
//  DateAndTime.swift
//  Feedback Builder
//
//  Created by UTKARSH VARMA on 2020-12-22.
//

import Foundation

struct DateAndTime{
    
    func getDisplayDate()->String{
        let date = Date()
        let calendar = Calendar.current
        let monthComponents = Calendar.current.shortMonthSymbols
        let monthNum = calendar.component(.month, from: date)
        let dayNum = Calendar.current.component(.weekday, from: Date())
        let dayComponents = Calendar.current.shortWeekdaySymbols
         return "\(dayComponents[dayNum]) \(calendar.component(.day, from: date)) \(monthComponents[monthNum-1]) \(calendar.component(.year, from: date))"
        
    }
}
