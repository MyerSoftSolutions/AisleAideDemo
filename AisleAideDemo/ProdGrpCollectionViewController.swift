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
        self.createCustomBackButton("Select Store")
        
        // Do any additional setup after loading the view.
    }

    override func navigationBackButtonClicked(_ sender: UIBarButtonItem) {
        self.lyle?.currentStore = nil
        self.lyle = nil
        self.navigationController?.popViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.prodGrpArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProdGrpCollectionCell", for: indexPath) as! ProdGrpCollectionCell
        
        let prodGp = self.prodGrpArray[(indexPath as NSIndexPath).row]
        
        cell.nameLabel.text = prodGp.name
//        cell.imageView.image = UIImage(named: )
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! ProdGrpCollectionCell
        let idxPath = self.collectionView.indexPath(for: cell)
        
        let pGrp = self.prodGrpArray[(idxPath! as NSIndexPath).row]
        
        if segue.identifier == "SelectItemSegue" {
            let vc = segue.destination as! ItemCollectionViewController
            vc.itemArray = []
            vc.itemArray = pGrp.items
            vc.lyle = self.lyle
        }
    }

}
