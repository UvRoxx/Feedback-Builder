//
//  SenderSettingsBrain.swift
//  Feedback Builder
//
//  Created by UTKARSH VARMA on 2020-11-30.
//


import UIKit
import CoreData

class SenderSettingsBrain{
    
    
    
    func saveUserName(_ senderName:String)
    {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "SenderInfo", in: context)
        let newEntity = NSManagedObject(entity:entity!, insertInto: context)
        newEntity.setValue(senderName , forKey: "senderName")
        do{
            try context.save()
            print("Sender Name Saved")
        }catch{
            print("Name Not Saved")
        }
        
    }
    
    
    func getUserName()->String{
        var senderName:String = ""
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "SenderInfo")
        request.returnsObjectsAsFaults = false
        do{
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject]
            {
                senderName = data.value(forKey: "senderName")as!String
            }
        }catch{
         print("Didnt Work")
        }
        return senderName
    }

}
