//
//  ProdGrpCollectionViewController.swift
//  AisleAideDemo
//
//  Created by Joel Myers on 10/5/16.
//  Copyright © 2016 MyerSoft Solutions. All rights reserved.
//

import UIKit


class ProdGrpCollectionViewController: AisleAideSetupViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var prodGrpArray : [ProductGroup]?
    var storeString : String?
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (storeString  != nil){
            self.initialSetUp()
        }

        self.collectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initialSetUp() {
        self.lyle = Lyle.defaultHelper
        self.lyle?.currentStore = Store.sharedStore
        
        self.lyle?.currentStore?.createAisleList(storeString!)
        self.prodGrpArray = self.lyle?.currentStore?.aisleList.getAllProdGrps()
        
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.prodGrpArray!.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
    }

}
