//
//  ItemTable.swift
//  Feedback Builder
//
//  Created by UTKARSH VARMA on 2021-01-16.
//

import UIKit
class ItemTable: UITableViewController {
    
    
    let itemBrain = ItemsBrain()
    var items = [Item]()
    
    var selectedCategory:ListCategory?{
        didSet{
            itemBrain.loadItems(selectedCategory: selectedCategory) { (error, loadedItems) in
                if let e = error{
                    print("Error Loading \(e)")
                }
                else{
                    items = loadedItems!
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    //MARK:-Reset Checklist Method
    @IBAction func resetCheckList(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title:"Reset The Check-List?", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title:"Yes", style: .default, handler: { (_) in
            for item in self.items{
                item.done = false
                if let error = self.itemBrain.save(){
                    print("Error Occoured Resetting \(error)")
                }else{
                    self.tableView.reloadData()
                }
            }
        }))
        alert.addAction(UIAlertAction(title: "No", style: .destructive, handler: { (_) in
            self.dismiss(animated: true, completion: nil)
        }))
        
        present(alert, animated: true, completion: nil)
    }
    
//MARK:-Add New Item Function
    @IBAction func addNewItem(_ sender: UIBarButtonItem) {
        var itemName = UITextField()
        
        
        let alert = UIAlertController(title: "New Item", message: "", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Add", style: .default) { (_) in
            
            if let finalInput = itemName.text
            {
                if finalInput != ""{
                    self.itemBrain.addNewItem(parentCategory: self.selectedCategory, itemName: finalInput) { (error, savedItems) in
                        if let e = error{
                            print("Error Occuereds Adding New Item \(e)")
                        }else{
                            self.items = savedItems!
                            self.tableView.reloadData()
                        }
                    }
                }
                
            }
            
        }
        alert.addTextField { (userInput) in
            itemName = userInput
        }
        alert.addAction(alertAction)
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Table view data source
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "items")
        cell.textLabel?.text  = items[indexPath.row].itemName
        if items[indexPath.row].done == true{
            cell.accessoryType = .checkmark
        }
        return cell
    }
    
    
    //MARK:-Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        items[indexPath.row].done = !items[indexPath.row].done
        if let error = itemBrain.save(){
            print(error)
        }else{
            tableView.reloadData()
        }
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            itemBrain.deleteItem(deletedIndex: indexPath) { (error, itemsAfterDeletion) in
                if let e = error{
                    print("There was an error deleting \(e)")
                }else{
                    self.items = itemsAfterDeletion!
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    
}
