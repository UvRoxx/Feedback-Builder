//
//  ListBuilder.swift
//  Feedback Builder
//
//  Created by UTKARSH VARMA on 2021-01-21.
//

import Foundation

struct ListBuilder{
    var categoryBrain = CategoryBrain()
    var itemsBrain    = ItemsBrain()
    
    var emailTitles         = [String]()
    var emailItems          = [String]()
    
    var category      = [ListCategory]()
    var items         = [[Item]]()
    
    mutating func buildListForMail(listsSelected:[IndexPath]){
        categoryBrain.loadCategory { (error, loadedCategory) in
            if let e = error{
                print("Error Loading Lists \(e)")
            }else{
                category = loadedCategory!
            }
        }
        
        for selected in listsSelected{
            let selectedCategory = category[selected.row]
            emailTitles.append(selectedCategory.categoryName!)
            itemsBrain.loadItems(selectedCategory: selectedCategory) { (error,itemsLoaded) in
                if let e = error{
                    print("error loading items in listbuilder \(e)")
                }else{
                    items.append(itemsLoaded!)
                }
            }
        }
       //Making the email content here
        print(emailTitles)
        print(items)
    }
    
}
