//
//  EmailViewController.swift
//  Feedback Builder
//
//  Created by UTKARSH VARMA on 2020-12-03.
//

import UIKit
import RealmSwift


class EmailViewController: UIViewController {
    var emailInfo:Results<EmailInfo>?
    let realm = try!Realm()
    var emailBrain = EmailBrain()
    @IBOutlet weak var newEmail: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newEmail.delegate = self
      //  allEmails = emailBrain.getEmailInfo()
      //  print(allEmails)
    }
    
    @IBAction func submitPressed(_ sender: UIButton) {
        
        if let currentEmail = newEmail.text{
            if emailBrain.isValidEmail(currentEmail){
                print("email is valid")
                
                let newEmailInfo = EmailInfo()
                newEmailInfo.email = (currentEmail)
                save(newEmailInfo)
            }else{
                print("email is invalid")
                let alert = emailBrain.emailAlert("Error", "Email is Invalid please check the info and try again")
                self.present(alert, animated: true, completion: nil)
            }
        }
        
        
        
    }
    @IBAction func showEmailTable(_ sender: UIButton) {
        let tableVC = storyboard?.instantiateViewController(identifier: "ListEmailViewController")as!GetSetEmailInfo
        tableVC.emailInfo = emailInfo
        present(tableVC, animated: true, completion: nil)
    }
    
    func save(_ savedData:EmailInfo){
        do{
            try realm.write{
                realm.add(savedData)
                print("Save Was Successful")
            }
        }catch{
            print("Error Saving Email \(error)")
        }
}
    
}

extension EmailViewController:UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        newEmail.resignFirstResponder()
        return true
    }
}
