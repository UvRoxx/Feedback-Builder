//
//  CategoryBrain.swift
//  Feedback Builder
//
//  Created by UTKARSH VARMA on 2021-01-18.
//

import UIKit
import CoreData
class CategoryBrain{
    let context = ((UIApplication.shared.delegate)as!AppDelegate).persistentContainer.viewContext
    
    
    
    //MARK:-Category Brain
    let categoryRequest: NSFetchRequest<ListCategory> = ListCategory.fetchRequest()
    
    var listCategory = [ListCategory]()
    //MARK:Add Category
    func addNewCategory(_ finalInput:String,completion:(String?,[ListCategory]?)->Void)
    {
        let newCategory = ListCategory(context: context)
        newCategory.categoryName = finalInput
        self.listCategory.append(newCategory)
        if let error = save(){
            completion(error,nil)
        }else{
            completion(nil,listCategory)

        }
    }
    
    //MARK:Load Category
    func loadCategory(completion:(String?,[ListCategory]?)->Void){
        
        do{
           listCategory = try context.fetch(categoryRequest)
            completion(nil,listCategory)
            print("Success loading data")
        }catch{
            completion(error.localizedDescription,nil)
        }
    }
    //MARK:Delete Category
    func delete(deleteAt:IndexPath,completion:(String?,[ListCategory]?)->Void){
        context.delete(listCategory[deleteAt.row])
        listCategory.remove(at: deleteAt.row)
        if let error = save(){
            completion(error,nil)

        }else{
            completion(nil,listCategory)
        }
    }
    

    //MARK:Save Function
    //This function is shared between the two
    func save()->String?{
        do{
           try context.save()
            return nil
        }catch{
            return error.localizedDescription
        }
    }
}
