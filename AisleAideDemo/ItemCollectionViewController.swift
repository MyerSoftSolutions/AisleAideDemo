//
//  ItemCollectionViewController.swift
//  AisleAideDemo
//
//  Created by Joel Myers on 10/7/16.
//  Copyright © 2016 MyerSoft Solutions. All rights reserved.
//

import UIKit

class ItemCollectionCell : ProdGrpCollectionCell {
    

}

class ItemCollectionViewController: AisleAideSetupViewController, UICollectionViewDelegate, UICollectionViewDataSource  {
    var itemArray : [Item] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        print(itemArray)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.itemArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ItemCollectionCell", forIndexPath: indexPath) as! ItemCollectionCell
        
        let item = self.itemArray[indexPath.row]
        
        cell.nameLabel.text = item.name
        //        cell.imageView.image = UIImage(named: )
        
        return cell
    }

}
