//
//  SenderSettingController.swift
//  Feedback Builder
//
//  Created by UTKARSH VARMA on 2020-11-30.
//

import UIKit
import AudioToolbox

protocol SetUserName{
    func getUserName(userName:String)
}
class UserNameSettings:
    UIViewController ,UITextFieldDelegate{
    let defaults = UserDefaults.standard
    var setUserNameDelegate:SetUserName?

    @IBOutlet weak var senderName: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        senderName.delegate = self
    }
    
    @IBAction func submitPressed(_ sender: Any) {

        if let finalName = senderName.text{
            defaults.setValue(finalName, forKey: "userName")
            setUserNameDelegate?.getUserName(userName: finalName)
            self.dismiss(animated: true, completion: nil)

        }
        
    }
 
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       
        if senderName.text != ""{
            senderName.placeholder = "Sender Name"
           
        }
        else
         
        {
            senderName.placeholder = "Please Enter Name"
            AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
           
        }
        senderName.resignFirstResponder()
        return true
    }
    
    
}

