//
//  ProductGroup.swift
//  AisleAideDemo
//
//  Created by Joel Myers on 8/24/16.
//  Copyright © 2016 MyerSoft Solutions. All rights reserved.
//

import UIKit

class ProductGroup: NSObject {
    var name : String?
    var aisle : Aisle?
    var items : [Item] = []
    
    convenience init(name: String, aisle: Aisle) {
        self.init()
        self.name = name
        self.aisle = aisle
    }

}
