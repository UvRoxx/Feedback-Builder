//
//  EmailBrain.swift
//  Feedback Builder
//
//  Created by UTKARSH VARMA on 2020-12-03.
//

import UIKit
import CoreData

struct EmailBrain{
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
    //MARK: -Save Email Info
    func saveEmail(_ emailInfo:[String])->Bool
    {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Email", in: context)
        let newEntity = NSManagedObject(entity:entity!, insertInto: context)
        newEntity.setValue(emailInfo , forKey: "emailInfo")
        do{
            try context.save()
            print(" Saved")
            return true
        }catch{
            print("Not Saved")
            return false
        }
        
    }
    
    //MARK: - Exttract Email Info
    func getEmailInfo()->[String]{
        var emails:[String] = [""]
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Email")
        request.returnsObjectsAsFaults = false
        do{
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject]
            {
                emails = data.value(forKey: "emailInfo")as![String]
            }
        }catch{
         print("Didnt Work")
        }
        return emails
    }
    
    
    
    

}
