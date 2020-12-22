//
//  SenderSettingController.swift
//  Feedback Builder
//
//  Created by UTKARSH VARMA on 2020-11-30.
//

import UIKit
import CoreData
import AudioToolbox
class SenderSettingController:
    UIViewController ,UITextFieldDelegate{
   
    var senderSettingsBrain = SenderSettingsBrain()
    @IBOutlet weak var senderName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        senderName.delegate = self
    }
    

  
    
    @IBAction func submitPressed(_ sender: Any) {
        
        senderSettingsBrain.saveUserName(senderName.text ?? "")
        self.dismiss(animated: true, completion: nil)
        
    }
    

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if senderName.text != ""{
            senderName.placeholder = "Sender Name"
            return true
        }
        else
         
        {
            senderName.placeholder = "Please Enter Name"
            AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
            return false
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       
        textField.resignFirstResponder()
        return true
    }
    
}

