//
//  EmailBuilder.swift
//  Feedback Builder
//
//  Created by UTKARSH VARMA on 2020-11-29.
//

import Foundation
import RealmSwift


struct EmailBuilder{
    var greet:String = "Respected Team"
    let defaults = UserDefaults.standard
    var end:String = "\n\nThank You.\nSincerely,\n"
    
   
     
    
    
    mutating func FinalEmailBuilder(TimerData: Throughput, salesData: SalesLabour, commentData: String)->String {
        let senderName = defaults.value(forKey: "userName") as? String ?? "Sender Name"
       
            
           
        let finalTimerDisplay = "\nToday our speed of service timers were as follows\n\nDP-2 = \(TimerData.dayPartTimer[0])\nDP-3 = \(TimerData.dayPartTimer[1])\nDP-4 = \(TimerData.dayPartTimer[2])\nDP-5 = \(TimerData.dayPartTimer[3])\nDP-6 = \(TimerData.dayPartTimer[4])"
        let salesDisplay:String = "\n\nFor the Following Timer we Had Sales of \(salesData.Sales ?? 0.0 )$ and Used Labour of \(salesData.Labour ?? 0.0)$"
            
            let commentDisplay:String = "\n---------------------------\nPersonal Comments\n---------------------------\n\(commentData)"
            
        let finalMail = "\(greet)\(finalTimerDisplay)\(salesDisplay)\(commentDisplay)\(end)\(senderName)\n\n\nMade with FeedbackBuilder Ver\(appVersion)"
            return finalMail
           
    }
    
    

    
    
}



