//
//  EmailViewController.swift
//  Feedback Builder
//
//  Created by UTKARSH VARMA on 2020-12-03.
//

import UIKit



class EmailViewController: UIViewController {
    var allEmails = [""]
    
    var emailBrain = EmailBrain()
    @IBOutlet weak var newEmail: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newEmail.delegate = self
        allEmails = emailBrain.getEmailInfo()
        print(allEmails)
    }
    
    @IBAction func submitPressed(_ sender: UIButton) {
        
        if let currentEmail = newEmail.text{
            if emailBrain.isValidEmail(currentEmail){
                print("email is valid")
                allEmails.append(currentEmail)
                if emailBrain.saveEmail(allEmails){
                let alert = emailBrain.emailAlert("Success", "Email Added Successfully")
                self.present(alert, animated: true, completion: nil)
                    newEmail.text = ""
                }else{
                    let alert = emailBrain.emailAlert("Error", "Email could not be added please try again")
                    self.present(alert, animated: true, completion: nil)
                }
            }else{
                print("email is invalid")
                let alert = emailBrain.emailAlert("Error", "Email is Invalid please check the info and try again")
                self.present(alert, animated: true, completion: nil)
            }
        }
        
        
        
    }
    @IBAction func showEmailTable(_ sender: UIButton) {
        let tableVC = storyboard?.instantiateViewController(identifier: "ListEmailViewController")as!ListEmailViewController
        present(tableVC, animated: true, completion: nil)
    }
    
    
}

extension EmailViewController:UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        newEmail.resignFirstResponder()
        return true
    }
}
