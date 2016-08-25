//
//  Aisle.swift
//  AisleAideDemo
//
//  Created by Joel Myers on 8/24/16.
//  Copyright © 2016 MyerSoft Solutions. All rights reserved.
//

import UIKit

class Aisle: NSObject {

    var aisleNumber : Int?
    var productGroups : [ProductGroup] = []
    
    convenience init(num: Int) {
        self.init()
        self.aisleNumber = num
    }
    
    func getAllItems()->[Item] {
        var prodArray : [Item] = []
        
        for prodGrp in self.productGroups {
            for item in prodGrp.items {
                prodArray.append(item)
            }
        }
        return prodArray
    }
    
}
