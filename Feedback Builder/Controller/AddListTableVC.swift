//
//  AddListTableVC.swift
//  Feedback Builder
//
//  Created by UTKARSH VARMA on 2021-01-21.
//

import UIKit

protocol addListToMail {
    func addListData(indexsSelected:[IndexPath])
}

class AddListTableVC: UITableViewController {
    var listToMailDelegate : addListToMail!
    var categoriesAdded    = [IndexPath]()
    let categoryBrain      = CategoryBrain()
    var listCategory       = [ListCategory]()
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        categoryBrain.loadCategory { (error, loadedCartgories) in
            if let e = error{
                print("error loading categories \(e)")
            }else{
                listCategory = loadedCartgories!
            }
        }
    }
    
    
    
    //MARK:-Data Source Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return listCategory.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "categoryCell")
        cell.textLabel?.text = listCategory[indexPath.row].categoryName
        if listCategory[indexPath.row].include{
            cell.accessoryType = .checkmark
            
        }
        return cell
    }
    //MARK:DELEGATE METHOD
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        listCategory[indexPath.row].include = !listCategory[indexPath.row].include
        if listCategory[indexPath.row].include{
            if !categoriesAdded.contains(indexPath){
                categoriesAdded.append(indexPath)
            }
        }else{
            if categoriesAdded.contains(indexPath){
                categoriesAdded.remove(at: categoriesAdded.firstIndex(of: indexPath)!)
            }
        }
        tableView.reloadData()
        print(categoriesAdded)
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        listToMailDelegate.addListData(indexsSelected: categoriesAdded)
    }
    
   
    
    
}
