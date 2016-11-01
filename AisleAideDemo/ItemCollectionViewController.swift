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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.itemArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCollectionCell", for: indexPath) as! ItemCollectionCell
        
        let item = self.itemArray[(indexPath as NSIndexPath).row]
        
        cell.nameLabel.text = item.name
        //        cell.imageView.image = UIImage(named: )
        
        return cell
    }

}
