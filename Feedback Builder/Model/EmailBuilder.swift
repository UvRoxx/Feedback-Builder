//
//  EmailBuilder.swift
//  Feedback Builder
//
//  Created by UTKARSH VARMA on 2020-11-29.
//

import Foundation



struct EmailBuilder{
   var senderSettingsBrain = SenderSettingsBrain()
    var greet:String = "Respected Team"
    
    var end:String = "\n\nThank You.\nSincerely,\n"
    
    var senderName = "Utkarsh Varma"
     
    
    
    mutating func FinalEmailBuilder(TimerData: Throughput, salesData: SalesLabour, commentData: String)->String {
        senderName = senderSettingsBrain.getUserName()
            
           
        let finalTimerDisplay = "\nToday our speed of service timers were as follows\n\nDP-2 = \(TimerData.dayPartTimer[0])\nDP-3 = \(TimerData.dayPartTimer[1])\nDP-4 = \(TimerData.dayPartTimer[2])\nDP-5 = \(TimerData.dayPartTimer[3])\nDP-6 = \(TimerData.dayPartTimer[4])"
            let salesDisplay:String = "\n\nFor the Following Timer we Had Sales of \(salesData.Sales)$ and Used Labour of \(salesData.Labour)$"
            
            let commentDisplay:String = "\n---------------------------\nPersonal Comments\n---------------------------\n\(commentData)"
            
            let finalMail = "\(greet)\(finalTimerDisplay)\(salesDisplay)\(commentDisplay)\(end)\(senderName)\n\n\nMade with FeedbackBuilder Ver\(appVersion)"
            return finalMail
           
    }
    
    

    
    
}



