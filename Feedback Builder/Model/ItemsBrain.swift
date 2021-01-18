//
//  ItemsBrain.swift
//  Feedback Builder
//
//  Created by UTKARSH VARMA on 2021-01-18.
//

import UIKit
import CoreData
class ItemsBrain{
    let context    = ((UIApplication.shared.delegate)as!AppDelegate).persistentContainer.viewContext
    let itemRequest: NSFetchRequest<Item> = Item.fetchRequest()
    let itemBrain                         = CategoryBrain()
    var items                             = [Item]()

    
    //MARK:- Adding New Items
    func addNewItem(parentCategory:ListCategory?,itemName:String,completion:(String?,[Item]?)->Void){
        let newItem = Item(context: context)
        newItem.itemName = itemName
        newItem.done = false
        newItem.parentCategory = parentCategory
        items.append(newItem)
        if let error = save(){
            completion(error,items)
        }else{
            completion(nil,items)
        }
       
    }
    
    
    
    
    //MARK:-Loading Saved Items
    func loadItems(selectedCategory:ListCategory?,completion:(String?,[Item]?)->Void){
        
        do{
           items = try context.fetch(itemRequest)
            var finalItems = [Item]()
            for item in items{
                if item.parentCategory == selectedCategory{
                    finalItems.append(item)
                }
                items = finalItems
            }
            completion(nil,items)
        }catch{
            completion(error.localizedDescription,items)
        }
    }
    
    
    //MARK:-Deleting Items
    func deleteItem(deletedIndex:IndexPath,completion:(String?,[Item]?)->Void){
        context.delete(items[deletedIndex.row])
        items.remove(at: deletedIndex.row)
        if let error = save(){
        completion(error,nil)
        }else{
            completion(nil,items)
        }
    }
    //MARK:Save Function
    func save()->String?{
        do{
           try context.save()
        return nil
        }catch{
            return error.localizedDescription
        }
    }
}
