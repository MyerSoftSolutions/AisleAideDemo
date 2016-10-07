//
//  ProdGrpCollectionViewController.swift
//  AisleAideDemo
//
//  Created by Joel Myers on 10/5/16.
//  Copyright © 2016 MyerSoft Solutions. All rights reserved.
//

import UIKit

class ProdGrpCollectionCell : UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabelView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
}

class ProdGrpCollectionViewController: AisleAideSetupViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var prodGrpArray : [ProductGroup] = []
    var storeString : String?
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.prodGrpArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ProdGrpCollectionCell", forIndexPath: indexPath) as! ProdGrpCollectionCell
        
        let prodGp = self.prodGrpArray[indexPath.row]
        
        cell.nameLabel.text = prodGp.name
//        cell.imageView.image = UIImage(named: )
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let cell = sender as! ItemCollectionCell
        let idxPath = self.collectionView.indexPathForCell(cell)
        
        let pGrp = self.prodGrpArray[idxPath!.row]
        
        if segue.identifier == "SelectItemSegue" {
            let vc = segue.destinationViewController as! ItemCollectionViewController
            vc.itemArray = []
            vc.itemArray = pGrp.items
            vc.lyle = self.lyle
        }
    }

}
