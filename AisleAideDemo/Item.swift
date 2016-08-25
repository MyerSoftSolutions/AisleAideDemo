//
//  Item.swift
//  AisleAideDemo
//
//  Created by Joel Myers on 8/24/16.
//  Copyright © 2016 MyerSoft Solutions. All rights reserved.
//

import UIKit

class Item: NSObject {
    
    var name : String?
    var productGroup : ProductGroup?
    var aisle : Aisle?
    var aisleNum : Int?
    
    
    convenience init(name: String, prodGroup: ProductGroup, aisle: Aisle) {
        self.init()
        self.name = name
        self.productGroup = prodGroup
        self.aisle = aisle
        
    }

}
