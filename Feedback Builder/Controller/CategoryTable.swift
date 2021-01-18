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
    var currentIndex = 0
    
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
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            context.delete(listCategory[indexPath.row])
            listCategory.remove(at: indexPath.row)
            save()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentIndex = indexPath.row
        performSegue(withIdentifier: "gotoItems", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let desitnationVC = segue.destination as! ItemTable
        desitnationVC.selectedCategory = listCategory[currentIndex]
        
    }
    
    func save(){
        do{
           try context.save()
            tableView.reloadData()
        }catch{
        print("Error Saving New Category\(error)")
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
