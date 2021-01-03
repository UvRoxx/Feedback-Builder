//
//  EmailBrain.swift
//  Feedback Builder
//
//  Created by UTKARSH VARMA on 2020-12-03.
//

import UIKit
import RealmSwift

struct EmailBrain{
    
    let realm = try!Realm()
    //MARK: -Email Validation
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func emailAlert(_ title:String,_ message:String)->UIAlertController
    {
        let alert = UIAlertController(title: title, message:message, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        

        return alert
    }

}
