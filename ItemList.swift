//
//  ItemList.swift
//  AisleAideDemo
//
//  Created by Joel Myers on 9/12/16.
//  Copyright © 2016 MyerSoft Solutions. All rights reserved.
//

import UIKit

class ItemList: NSObject {
    var itemArray : [Item] = []
    
    func addNewItem(_ item: Item) {
        self.itemArray.append(item)
    }
    
    func getItemList() -> [Item] {
        return self.itemArray
    }

}
