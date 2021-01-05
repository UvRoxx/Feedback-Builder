//
//  FBErrors.swift
//  Feedback Builder
//
//  Created by UTKARSH VARMA on 2021-01-05.
//

import Foundation
//MARK:-EM = ERROR MESSAGE
enum EM:String,Error{
    
    case noUserNameFound       = "Please Enter a Username from settings"
    case unspecifiedError      = "Unspecified Error Occoured"
    case emailNotSent          = "Email Not Sent"
    case actionCancelled       = "The Action was Cancelled"
    case movedToDraft          = "The email has been saved and can be accessed from the draft section of the mail app"
    case emailSentSuccessfully = "Email Sent Successfully"
    case mailNotSet            = "Please setup your email in the mail app to send mails, thank You"
    
}
