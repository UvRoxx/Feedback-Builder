//
//  ListEmailViewController.swift
//  Feedback Builder
//
//  Created by UTKARSH VARMA on 2020-12-03.
//

import UIKit
import CoreData
class RecipentsDisplay: UIViewController,UITableViewDelegate, UITableViewDataSource{
    
    var emailInfo = [Contacts]()
    let context = ((UIApplication.shared.delegate)as!AppDelegate).persistentContainer.viewContext

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return emailInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "emailCell", for: indexPath)
        cell.textLabel?.text = emailInfo[indexPath.row].recipentMail
        return cell
    }
    
    
    //MARK:-Delete Row DeleagteMethod
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == UITableViewCell.EditingStyle.delete
        {
            context.delete(emailInfo[indexPath.row])
            emailInfo.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        load()
        
    }
    
    func load(){
        let request: NSFetchRequest<Contacts> = Contacts.fetchRequest()
        do{
            emailInfo = try context.fetch(request)
        }catch{
            print("Error Fetching data")
        }
    }
  
}
