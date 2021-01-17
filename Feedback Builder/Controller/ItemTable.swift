//
//  ItemTable.swift
//  Feedback Builder
//
//  Created by UTKARSH VARMA on 2021-01-16.
//

import UIKit
import CoreData
class ItemTable: UITableViewController {

    let context = ((UIApplication.shared.delegate)as!AppDelegate).persistentContainer.viewContext

    
    let request: NSFetchRequest<Item> = Item.fetchRequest()
    var items = [Item]()

    var selectedCategory:ListCategory?{
        didSet{
            load()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    @IBAction func addNewItem(_ sender: UIBarButtonItem) {
        var itemName = UITextField()
        
        let newItem = Item(context: context)
        
        let alert = UIAlertController(title: "New Item", message: "", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Add", style: .default) { (_) in
        
            if let finalInput = itemName.text
            {
                if finalInput != ""{
                    newItem.itemName = finalInput
                    newItem.done = false
                    newItem.parentCategory = self.selectedCategory
                    self.items.append(newItem)
                    self.save()
                    print("Success")
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
    
    
    //MARK:-Save Function

    func save(){
        do{
           try context.save()
            tableView.reloadData()
        }catch{
        fatalError("Error Saving Item \(error)")
        }
        
    }
    func load(){
        
        do{
           items = try context.fetch(request)
            var finalItems = [Item]()
            for item in items{
                if item.parentCategory == selectedCategory{
                    finalItems.append(item)
                }
                items = finalItems
            }
        print("Success loading data")
        }catch{
            print("Error loading data")
        }
    }
}
