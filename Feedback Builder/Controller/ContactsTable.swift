//
//  ListEmailViewController.swift
//  Feedback Builder
//
//  Created by UTKARSH VARMA on 2020-12-03.
//

import UIKit
import RealmSwift
class ContactsTable: UIViewController,UITableViewDelegate, UITableViewDataSource{
    
    var emailInfo:Results<Contact>?
    let realm = try!Realm()
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return emailInfo?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "emailCell", for: indexPath)
        cell.textLabel?.text = emailInfo?[indexPath.row].email ?? "No Emails Found"
        return cell
    }
    
    
//MARK:-Delete Row DeleagteMethod
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == UITableViewCell.EditingStyle.delete
        {
            if let deletedEmail = emailInfo?[indexPath.row]{
                do{
                    try realm.write{
                        realm.delete(deletedEmail)
                        tableView.reloadData()
                    }
                    }catch{
                        print("Error Deleting Email \(error)")
                    }
                }
            }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        load()
       
    }
    

    func load(){
        emailInfo = realm.objects(Contact.self)
    }
}
