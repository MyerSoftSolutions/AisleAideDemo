//
//  ProdGrpCollectionViewController.swift
//  AisleAideDemo
//
//  Created by Joel Myers on 10/5/16.
//  Copyright © 2016 MyerSoft Solutions. All rights reserved.
//

import UIKit
import QuartzCore

class ProdGrpCollectionCell : UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabelView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
}

class ProdGrpCollectionViewController: AisleAideSetupViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var prodGrpArray : [ProductGroup] = []
    var storeString : String?
    var listConstructed = false
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var salesBtn: UIButton!
    @IBOutlet weak var couponBtn: UIButton!
    @IBOutlet weak var exploreBtn: UIButton!
    
   @IBOutlet var topButtons : [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.collectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        if !listConstructed {
            self.createCustomBackButton("Select Store")
        } else {
            self.createCustomBackButton("My List")

        }
        
        
        salesBtn.layer.borderColor = UIColor(colorLiteralRed:  241.0, green: 255.0, blue: 145.0, alpha: 1.0).cgColor
        salesBtn.layer.borderWidth = 1.0
        salesBtn.layer.cornerRadius = 14.0

        couponBtn.layer.borderColor = UIColor(colorLiteralRed:  241.0, green: 255.0, blue: 145.0, alpha: 1.0).cgColor
        couponBtn.layer.borderWidth = 1.0
        couponBtn.layer.cornerRadius = 14.0


        exploreBtn.layer.borderColor = UIColor(colorLiteralRed:  241.0, green: 255.0, blue: 145.0, alpha: 1.0).cgColor
        exploreBtn.layer.borderWidth = 1.0
        exploreBtn.layer.cornerRadius = 14.0


        // Do any additional setup after loading the view.
    }

    override func navigationBackButtonClicked(_ sender: UIBarButtonItem) {
//        self.lyle?.currentStore = nil
//        self.lyle = nil
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func topBtnPressed(_ sender: UIButton) {
        if sender.tag == 10 {
        //Sales Btn Pressed
            
        } else if sender.tag == 20 {
        //Coupons Btn Pressed
            
        } else {
        //Explore Btn Pressed
            
        }
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
