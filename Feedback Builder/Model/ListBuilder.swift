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
    
    var emailTitles    = [String]()
    var emailItems     = [String:[String]]()
    var tempItemNames  = [String]()

    
    var category      = [ListCategory]()
    
    mutating func buildListForMail(listsSelected:[Int])->String{
        emailTitles = [String]()
        if listsSelected.count == 0{
            return ""
        }
        
            
        categoryBrain.loadCategory { (error, loadedCategory) in
            if let e = error{
                print("Error Loading Lists \(e)")
            }else{
                category = loadedCategory!
            }
        }
        
        for selected in listsSelected{
            tempItemNames = [String]()
            let selectedCategory = category[selected]
            emailTitles.append(selectedCategory.categoryName!)
            itemsBrain.loadItems(selectedCategory: selectedCategory) { (error,itemsLoaded) in
                if let e = error{
                    print("error loading items in listbuilder \(e)")
                }else{
                //This function once getting hold of the items saved for the selected category name automatically loads them into a
                //Array of String objects to be added tot he dictonary so that it can be read later using the catgoeyr name when building
                    let selectedItems = itemsLoaded!
                    for items in selectedItems{
                    tempItemNames.append(items.itemName!)
                    }
                    
                }
            }
            emailItems[selectedCategory.categoryName!] = tempItemNames
        }
        
        //Making the email content here
        var emailContent = ""
           emailContent+=("\n---------------\nTodays CheckList\n---------------")
            for titles in emailTitles{
                emailContent+=("\n------------\n")
                emailContent+=(titles)+"\n"
                emailContent+=("------------\n")
                for item in emailItems[titles]!{
                    emailContent+=(item)+"\n"
                }
            }
        emailContent+="\n\n"//Extra Spacing to make email more easily readable
        return emailContent

    }
}
