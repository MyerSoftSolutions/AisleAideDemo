//
//  Store.swift
//  AisleAideDemo
//
//  Created by Joel Myers on 8/24/16.
//  Copyright © 2016 MyerSoft Solutions. All rights reserved.
//

import UIKit

class Store: NSObject {
    var name : String?
    var address : String?
    var numOfAisles : Int?
    
    var aisleList : AisleList = AisleList()
    static let sharedStore = Store()

    func createAisleList(storeName: String) {
        let path : String = NSBundle.mainBundle().pathForResource(storeName, ofType: "plist")!
        let dict = NSDictionary(contentsOfFile: path) as? [String: AnyObject]
        
        let aisles : [[String: AnyObject]] = dict!["Aisles"] as! [[String: AnyObject]]
        
        var i = 1
        
        for dict in aisles {
            let aisle = Aisle(num: i)
            let prdGrp = dict["ProductGroups"] as! [[String: AnyObject]]
            
            for diction in prdGrp {
                let pG = ProductGroup(name: diction["name"] as! String, aisle: aisle)
                
                let pgItems = dict["Items"] as! [[String: AnyObject]]
                for dict in pgItems {
                    let item = Item(name: dict["name"] as! String, prodGroup: pG, aisle: aisle)
                    item.aisleNum = i
                    
                    pG.items.append(item)
                }
                
                aisle.productGroups.append(pG)
            }
            self.aisleList.aisleArray.append(aisle)
            i += 1
        }
        
        self.numOfAisles = self.aisleList.aisleArray.count
    }
    
}
