//
//  ListTableController.swift
//  Feedback Builder
//
//  Created by UTKARSH VARMA on 2021-01-15.
//

import UIKit

class CategoryTable: UITableViewController {
    
    var currentIndex  = 0
    var listCategory  = [ListCategory]()
    let categoryBrain = CategoryBrain()//This is object that is only made to access the category part of the CategoryAndItemBrain and hence named category brain
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryBrain.loadCategory { (error, savedCategories) in
            if let e = error{
                print("Error Loading Saved Categories \(e)")

            }else{
                listCategory = savedCategories!

            }
        }
    }
    
    //MARK:- Data Source Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listCategory.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = listCategory[indexPath.row].categoryName
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    
    //MARK:-Add And Delete Methods
    @IBAction func addNewCategory(_ sender: Any) {
        
        
        var categoryName = UITextField()
        
        let alert = UIAlertController(title: "New Category", message: "", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Add", style: .default) { (_) in
            
            if let finalInput = categoryName.text
            {
                if finalInput != ""{
                    self.categoryBrain.addNewCategory(finalInput) { (errors, savedInfo) in
                        if let e = errors{
                            print("Error Saving \(e)")
                            
                        }else{
                            self.listCategory = savedInfo!
                            self.tableView.reloadData()
                        }
                    }
                }
                
            }
            
        }
        alert.addTextField { (userInput) in
            categoryName = userInput
        }
        alert.addAction(alertAction)
        present(alert, animated: true, completion: nil)
    }
    
    

    
        override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete{
                categoryBrain.delete(deleteAt: indexPath) { (error, listAfterDeletion) in
                    if let e=error{
                        print("Error Deleting \(e)")

                    }else{
                        
                        listCategory = listAfterDeletion!
                        tableView.reloadData()
                    }
                }
            }
        }
    
    
    
    //MARK:-Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentIndex = indexPath.row
        performSegue(withIdentifier: "gotoItems", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let desitnationVC = segue.destination as! ItemTable
        desitnationVC.selectedCategory = listCategory[currentIndex]
        
    }
    
}
