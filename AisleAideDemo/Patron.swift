//
//  Patron.swift
//  AisleAideDemo
//
//  Created by Joel Myers on 8/24/16.
//  Copyright © 2016 MyerSoft Solutions. All rights reserved.
//

import UIKit

class Patron: NSObject {
    
    var name : String?
    var userID : Int?
    var itemList : [Item]?
    
    convenience init(name: String, userID: Int) {
        self.init()
        self.name = name
        self.userID = userID
    }

}
