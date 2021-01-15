//
//  ListTableController.swift
//  Feedback Builder
//
//  Created by UTKARSH VARMA on 2021-01-15.
//

import UIKit
import CoreData

class CategoryTable: UITableViewController {
    
    let context = ((UIApplication.shared.delegate)as!AppDelegate).persistentContainer.viewContext
    let request: NSFetchRequest<ListCategory> = ListCategory.fetchRequest()
    
    var listCategory = [ListCategory]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        load()
        
    }
    
    
    @IBAction func addNewCategory(_ sender: Any) {
        var categoryName = UITextField()
        
        let newCategory = ListCategory(context: context)
        
        let alert = UIAlertController(title: "New Category", message: "", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Add", style: .default) { (_) in
        
            if let finalInput = categoryName.text
            {
                if finalInput != ""{
                    newCategory.categoryName = finalInput
                    self.listCategory.append(newCategory)
                    self.save()
                    print("Success")
                }
              
            }
            
        }
        alert.addTextField { (userInput) in
            categoryName = userInput
        }
        alert.addAction(alertAction)
        present(alert, animated: true, completion: nil)
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listCategory.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = listCategory[indexPath.row].categoryName
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            context.delete(listCategory[indexPath.row])
            listCategory.remove(at: indexPath.row)
            save()
        }
    }
    
    func save(){
        do{
           try context.save()
            tableView.reloadData()
        }catch{
        fatalError("Error Saving New Cateogyr")
        }
    }
    func load(){
        
        do{
           listCategory = try context.fetch(request)
        print("Success loading data")
        }catch{
            print("Error loading data")
        }
    }
}
