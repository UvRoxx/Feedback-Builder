//
//  ListEmailViewController.swift
//  Feedback Builder
//
//  Created by UTKARSH VARMA on 2020-12-03.
//

import UIKit

class ListEmailViewController: UIViewController,UITableViewDelegate, UITableViewDataSource{
    
    var emailBrain = EmailBrain()
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return emailBrain.getEmailInfo().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myData = emailBrain.getEmailInfo()
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = myData[indexPath.row]
        return cell
    }
    
    //To delete row when user swipes
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == UITableViewCell.EditingStyle.delete
        {
            var myData = emailBrain.getEmailInfo()
            
            myData.remove(at: indexPath.row)
            if emailBrain.saveEmail(myData){
            
            present(emailBrain.emailAlert("Deleted", "Contact succcessfully deleted"), animated: true, completion: nil)
            }else{
                
                present(emailBrain.emailAlert("Error", "Email Not Deleted"), animated: true, completion: nil)
            }
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    

    
}
