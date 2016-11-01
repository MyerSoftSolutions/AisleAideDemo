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

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let alertController = UIAlertController(title: nil, message: "Add more items?", preferredStyle: .actionSheet)
        
        let yesAction = UIAlertAction(title: "Yes", style: .default) { (action) in
            // ...
        }
        alertController.addAction(yesAction)
        
        let noAction = UIAlertAction(title: "No", style: .destructive) { (action) in
            self.performSegue(withIdentifier: "ShowListSegue", sender: self)
        }
        alertController.addAction(noAction)
        
        self.present(alertController, animated: true) {
            // ...
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowListSegue" {
            let vc = segue.destination as! ItemListViewController
            vc.lyle = self.lyle
        }
    }
    
}
