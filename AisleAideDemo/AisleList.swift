//
//  AisleList.swift
//  AisleAideDemo
//
//  Created by Joel Myers on 8/24/16.
//  Copyright © 2016 MyerSoft Solutions. All rights reserved.
//

import UIKit


class Lyle {
    static let defaultHelper = Lyle()
    
    var currentItemList : ItemList?
    var currentPatron : Patron?
    var currentStore : Store?
    
    func addSelectedItem(selectedItem: Item) -> Void {
        if self.currentItemList == nil {
            self.currentItemList = ItemList()
            self.currentItemList?.addNewItem(selectedItem)
        } else {
            self.currentItemList?.addNewItem(selectedItem)
        }
    }
    
    func removeLastItem() {
        self.currentItemList?.itemArray.removeAtIndex((self.currentItemList?.itemArray.count)! - 1)
    }
}

class AisleList: NSObject {
    var aisleArray : [Aisle] = []
    
    func getAllProdGrps()->[ProductGroup]{
        var arr : [ProductGroup] = []
        
        for aisle in self.aisleArray{
            for prdGrp in aisle.productGroups{
                arr.append(prdGrp)
            }
        }
        
        arr.sortInPlace({$0.name < $1.name})
        return arr
        
    }
    
    func isItemInArray(itemArray: [Item], suggestedItem: Item)->Bool{
        var isInArray : Bool = false
        
        for item in itemArray{
            if item == suggestedItem {
                isInArray = true;
                break
            }
        }
        
        return isInArray
    }
    
    func alsoOnThisAisle(aisle: Aisle, item: Item, itemArray: [Item])->[Item]{
        var items : [Item] = []
        
        for var k = 0; k < 3; k += 1 {
            let randomNum = Int(arc4random_uniform(UInt32(aisle.productGroups.count)))
            let pGroup = aisle.productGroups[randomNum]
            
            let randomNum2 = Int(arc4random_uniform(UInt32(pGroup.items.count)))
            let suggestedItem = pGroup.items[randomNum2]
            
            if suggestedItem == item || self.isItemInArray(items, suggestedItem: suggestedItem) || self.isItemInArray(itemArray, suggestedItem: suggestedItem) {
                k -= 1
                continue
            } else {
                items.append(suggestedItem)
            }
            
        }
        
        return items
    
    }
    
    func oneAisleOver(aisle: Aisle, userItemArray:[Item])->[Item]{
        var items : [Item] = []
        var singleSuggestedItems : [Item] = []
        var doubleSuggestedItems : [Item] = []
        
        let homeAisle = aisle.aisleNumber! - 1
        let leftAisle = homeAisle - 1
        let rightAisle = homeAisle + 1
        
        var count = 1
        
        if homeAisle == 0 {
            let aisleRight : Aisle = self.aisleArray[rightAisle]
            items = aisleRight.getAllItems()
            
            while count < 4 {
                let k = Int(arc4random_uniform(UInt32(items.count)))
                let suggestedItem : Item = items[k]
                
                if self.isItemInArray(userItemArray, suggestedItem: suggestedItem) {
                    continue
                } else {
                    singleSuggestedItems.append(suggestedItem)
                    count += 1
                }
            }
            return singleSuggestedItems
            
        } else if (homeAisle + 1) == self.aisleArray.count {
            let aisleLeft : Aisle = self.aisleArray[leftAisle]
            items = aisleLeft.getAllItems()
            
            while count < 4 {
                let k = Int(arc4random_uniform(UInt32(items.count)))
                let suggestedItem : Item = items[k]
                
                if self.isItemInArray(userItemArray, suggestedItem: suggestedItem) {
                    continue
                } else {
                    singleSuggestedItems.append(suggestedItem)
                    count += 1
                }
            }
            return singleSuggestedItems
            
        } else {
            let aisleLeft : Aisle = self.aisleArray[leftAisle]
            items = aisleLeft.getAllItems()
            
            while count < 3 {
                let k = Int(arc4random_uniform(UInt32(items.count)))
                let suggestedItem : Item = items[k]
                
                if self.isItemInArray(userItemArray, suggestedItem: suggestedItem) {
                    continue
                } else {
                    doubleSuggestedItems.append(suggestedItem)
                    count += 1
                }
            }
            
            let aisleRight : Aisle = self.aisleArray[rightAisle]
            items = aisleRight.getAllItems()

            let k = Int(arc4random_uniform(UInt32(items.count)))
            doubleSuggestedItems.append(items[k])
            count += 1
            
            return doubleSuggestedItems
        }
    
    }
    
    
}
