//
//  EmailViewController.swift
//  Feedback Builder
//
//  Created by UTKARSH VARMA on 2020-12-03.
//

import UIKit
import CoreData



class EmailViewController: UIViewController {
    var emailInfo = [Contacts]()
    let emailBrain = EmailBrain()
    let context = ((UIApplication.shared.delegate)as!AppDelegate).persistentContainer.viewContext
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
                
                let newEmailInfo = Contacts(context: context)
                newEmailInfo.recipentMail = (currentEmail)
                save()
            }else{
                print("email is invalid")
                let alert = emailBrain.emailAlert("Error", "Email is Invalid please check the info and try again")
                self.present(alert, animated: true, completion: nil)
            }
        }
        
        
        
    }
    @IBAction func showEmailTable(_ sender: UIButton) {
        let tableVC = storyboard?.instantiateViewController(identifier: "ListEmailViewController")as!RecipentsDisplay
        tableVC.emailInfo = emailInfo
        present(tableVC, animated: true, completion: nil)
    }

    func save(){
        do{
            try context.save()
        }catch{
            print("Error Saving Data")
        }
    }
}

extension EmailViewController:UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        newEmail.resignFirstResponder()
        return true
    }
}
