//
//  ItemListViewController.swift
//  AisleAideDemo
//
//  Created by Joel Myers on 11/1/16.
//  Copyright © 2016 MyerSoft Solutions. All rights reserved.
//

import UIKit

class ItemTableCell : UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var aisleLabel: UILabel!
    @IBOutlet weak var separatorView: UIView!
}

class SuggestionsCollectionCell : UICollectionViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var aisleLabel: UILabel!

}

class SuggestionsTableCell : UITableViewCell, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var itemArray : [Item] = []
    
    @IBOutlet weak var collectionViewHeightCon: NSLayoutConstraint!
    override func prepareForReuse() {
        self.itemArray = []
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
        
    }

    
    // MARK: UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
         return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.itemArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        <#code#>
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.collectionView.frame.width/2.75 - 5), height: self.collectionViewHeightCon.constant) // The size of one cell
        
    }

    
    //Use for interspacing
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(10, 20, 10, 20) // margin between cells
    }

    
}

class ItemListViewController: AisleAideSetupViewController, UITableViewDataSource, UITableViewDelegate {
    var itemArray : [Item] = []
    var rowPressed = false
    var selectedRow : Int?
    var alsoOnThisArray, oneAisleOverArray : [Item]?
    var indexPaths : [AnyObject]?
    
    @IBOutlet weak var itemsCountLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createCustomBackButton("+Add Item")
        self.title = "My ItemList"
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 68.0

        
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print((Lyle.defaultHelper.currentItemList?.itemArray.count)!)
        itemArray = (Lyle.defaultHelper.currentItemList?.itemArray)!
        self.itemsCountLabel.text = String(format:"Items: %d", self.itemArray.count)

        tableView.reloadData()

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.itemArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemTableCell", for: indexPath) as! ItemTableCell
        
        let item = self.itemArray[indexPath.row]
        cell.nameLabel.text = item.name
        cell.aisleLabel.text = "\(item.aisleNum!)"
        print(cell.aisleLabel.text!)
        
        return cell
    }

    
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 68.0
    }
}
