//
//  AisleList.swift
//  AisleAideDemo
//
//  Created by Joel Myers on 8/24/16.
//  Copyright © 2016 MyerSoft Solutions. All rights reserved.
//

import UIKit

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
            
            
        }
        
        return items
    
    }
    
    func oneAisleOver()->[Item]{
    
    }
    
    
}
