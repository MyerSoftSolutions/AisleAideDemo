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

class ItemCollectionViewController: AisleAideSetupViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    var itemArray : [Item] = []
    var selectedItem : Item?
    var itemAlreadyExists : Bool = false
    
    @IBOutlet weak var salesBtn: UIButton!
    @IBOutlet weak var couponBtn: UIButton!
    @IBOutlet weak var exploreBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(itemArray)
        salesBtn.layer.borderColor = UIColor(colorLiteralRed:  241.0, green: 255.0, blue: 145.0, alpha: 1.0).cgColor
        salesBtn.layer.borderWidth = 1.0
        salesBtn.layer.cornerRadius = 14.0
        
        couponBtn.layer.borderColor = UIColor(colorLiteralRed:  241.0, green: 255.0, blue: 145.0, alpha: 1.0).cgColor
        couponBtn.layer.borderWidth = 1.0
        couponBtn.layer.cornerRadius = 14.0
        
        
        exploreBtn.layer.borderColor = UIColor(colorLiteralRed:  241.0, green: 255.0, blue: 145.0, alpha: 1.0).cgColor
        exploreBtn.layer.borderWidth = 1.0
        exploreBtn.layer.cornerRadius = 14.0        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedItem = self.itemArray[indexPath.row]
        print(self.selectedItem!)
        print((self.lyle?.currentItemList)!)
        print(self.selectedItem!)

        if self.isItemInArray(itemList:(self.lyle?.currentItemList)!, suggestedItem:self.selectedItem!) {
            itemAlreadyExists = true
            self.shouldPerformSegue(withIdentifier: "AddMoreItemsSegue", sender:self)
        } else{
            self.lyle?.addSelectedItem(self.selectedItem!)
//            let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddMoreItemsViewController") as! AddMoreItemsViewController
//            vc.addItemsDelegate = self;
//            vc.lyle = self.lyle
//            self.navigationController?.pushViewController(vc, animated:true)
        }
        
        self.performSegue(withIdentifier: "MoreItemsSegue", sender: self)
//        let alertController = UIAlertController(title: nil, message: "Add more items?", preferredStyle: .actionSheet)
//        
//        let yesAction = UIAlertAction(title: "Yes", style: .default) { (action) in
//            // ...
//        }
//        alertController.addAction(yesAction)
//        
//        let noAction = UIAlertAction(title: "No", style: .destructive) { (action) in
//            self.performSegue(withIdentifier: "ShowListSegue", sender: self)
//        }
//        alertController.addAction(noAction)
//        
//        self.present(alertController, animated: true) {
//            // ...
//        }
    }
    
    func isItemInArray(itemList: ItemList, suggestedItem: Item) -> Bool {
        var isInArray = false
        
        for item in itemList.itemArray {
            if item == suggestedItem {
                isInArray = true
            }
        }
        return isInArray
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MoreItemsSegue" {
            let vc = segue.destination as! AddMoreItemsViewController
            vc.lyle = Lyle.defaultHelper
        }
    }
    
}
