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
    var retrievedItemsArray : [Item] = []
    
    func addNewItem(_ item: Item) {
        self.itemArray.append(item)
    }
    
    func getItemList() -> [Item] {
        return self.itemArray
    }

    func addRetrievedItem(_ item: Item) {
        self.retrievedItemsArray.append(item)
    }

    func getRetrievedItems() -> [Item] {
        return self.retrievedItemsArray
    }
}
