//
//  AddListTableVC.swift
//  Feedback Builder
//
//  Created by UTKARSH VARMA on 2021-01-21.
//

import UIKit

protocol addListToMail {
    func addListData(indexsSelected:[Int])
}

class AddListTableVC: UITableViewController {
    var listToMailDelegate : addListToMail!
    var categoriesAdded    = [Int]()
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
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        listToMailDelegate.addListData(indexsSelected: categoriesAdded)
        print("categories sent= \(categoriesAdded)")
    }
    
    //MARK:-Data Source Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return listCategory.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "checkCategoryCell")
        cell.textLabel?.text = listCategory[indexPath.row].categoryName
        
        if categoriesAdded.contains(indexPath.row){
            cell.accessoryType = .checkmark
            
        }
        return cell
    }
    //MARK:DELEGATE METHOD
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        if !categoriesAdded.contains(indexPath.row){
            categoriesAdded.append(indexPath.row)
        }
        else if categoriesAdded.contains(indexPath.row){
            categoriesAdded.remove(at: categoriesAdded.firstIndex(of: indexPath.row)!)
        }
        tableView.reloadData()
        print(categoriesAdded)
        
    }
    
}







