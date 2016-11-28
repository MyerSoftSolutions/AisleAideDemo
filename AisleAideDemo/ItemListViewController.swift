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
    var parentController : ItemListViewController?
    var itemArray : [Item] = []
    
    @IBOutlet weak var collectionViewHeightCon: NSLayoutConstraint!
    override func prepareForReuse() {
        self.itemArray = []
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
        
    }

//    override func awakeFromNib() {
//        <#code#>
//    }
    // MARK: UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
         return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.itemArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : SuggestionsCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "SuggestionsCollectionCell", for: indexPath) as! SuggestionsCollectionCell
        
        
        let item = self.itemArray[indexPath.row]
        cell.nameLabel.text = item.name!
        cell.aisleLabel.text = "\(item.aisleNum!)"
        
        return cell

    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = self.itemArray[indexPath.row]
        
        Lyle.defaultHelper.addSelectedItem(item)
        self.parentController?.itemArray = (Lyle.defaultHelper.currentItemList?.itemArray)!
        self.parentController?.itemsCountLabel.text = String(format:"Items: %d", (self.parentController?.itemArray.count)!)
        self.parentController?.itemArray.sort(by: {$0.aisle!.aisleNumber! < $1.aisle!.aisleNumber!})

        self.parentController?.rowPressed = false
        self.parentController?.suggestedItemArray?.removeAll(keepingCapacity: true)
        self.parentController?.suggestedCellIndexPath = nil
        self.parentController?.tableView.reloadData()
        
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
    var suggestedCellIndexPath : IndexPath?
    var suggestedItemArray : [Item]?
    
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

    override func navigationBackButtonClicked(_ sender: UIBarButtonItem) {
        let prodGrpVC = self.storyboard?.instantiateViewController(withIdentifier: "ProdGrpCollectionViewController") as! ProdGrpCollectionViewController
        prodGrpVC.lyle = Lyle.defaultHelper
        prodGrpVC.prodGrpArray = (prodGrpVC.lyle?.currentStore?.aisleList.getAllProdGrps())!
        prodGrpVC.listConstructed = true
        
        self.navigationController?.popToViewController((self.navigationController?.viewControllers[(self.navigationController?.viewControllers.count)! - 1])!, animated: true)
        self.navigationController?.pushViewController(prodGrpVC, animated: true)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print((Lyle.defaultHelper.currentItemList?.itemArray.count)!)
        itemArray = (Lyle.defaultHelper.currentItemList?.itemArray)!
        itemArray.sort(by: {$0.aisle!.aisleNumber! < $1.aisle!.aisleNumber!})
        self.itemsCountLabel.text = String(format:"Items: %d", self.itemArray.count)

        tableView.reloadData()

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if rowPressed {
            return self.itemArray.count + 1
        } else {
            return self.itemArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if suggestedCellIndexPath != nil {
            if indexPath != suggestedCellIndexPath {
                let cell = tableView.dequeueReusableCell(withIdentifier: "ItemTableCell", for: indexPath) as! ItemTableCell
                
                let item = self.itemArray[indexPath.row]
                cell.nameLabel.text = item.name
                cell.aisleLabel.text = "\(item.aisleNum!)"
                print(cell.aisleLabel.text!)
                
                return cell


            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "SuggestionsTableCell", for: indexPath) as! SuggestionsTableCell
                cell.parentController = self
                cell.itemArray = self.suggestedItemArray!
                return cell

            }
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ItemTableCell", for: indexPath) as! ItemTableCell
            
            let item = self.itemArray[indexPath.row]
            cell.nameLabel.text = item.name
            cell.aisleLabel.text = "\(item.aisleNum!)"
            print(cell.aisleLabel.text!)
            
            return cell

        }
        
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !rowPressed {
            rowPressed = true
            selectedRow = indexPath.row
            let section = indexPath.section
            suggestedCellIndexPath = IndexPath(row: selectedRow! + 1, section: section)
            
            
            //Build SuggestionItemArray of 6 Items
            if suggestedItemArray != nil {
                suggestedItemArray?.removeAll(keepingCapacity: true)
                
                let item = self.itemArray[indexPath.row]
                
                alsoOnThisArray = Lyle.defaultHelper.currentStore?.aisleList.alsoOnThisAisle(item: item, itemArray: (Lyle.defaultHelper.currentItemList?.itemArray)!)
                for item in alsoOnThisArray! {
                    suggestedItemArray?.append(item)
                }
                
                oneAisleOverArray = Lyle.defaultHelper.currentStore?.aisleList.oneAisleOver(item.aisle!, userItemArray: (Lyle.defaultHelper.currentItemList?.itemArray)! )
                for item in oneAisleOverArray! {
                    suggestedItemArray?.append(item)
                }

            } else {
                suggestedItemArray = []
                suggestedItemArray?.reserveCapacity(6)
                
                let item = self.itemArray[indexPath.row]

                alsoOnThisArray = Lyle.defaultHelper.currentStore?.aisleList.alsoOnThisAisle(item: item, itemArray: (Lyle.defaultHelper.currentItemList?.itemArray)!)
                for item in alsoOnThisArray! {
                    suggestedItemArray?.append(item)
                }
                
                oneAisleOverArray = Lyle.defaultHelper.currentStore?.aisleList.oneAisleOver(item.aisle!, userItemArray: (Lyle.defaultHelper.currentItemList?.itemArray)! )
                for item in oneAisleOverArray! {
                    suggestedItemArray?.append(item)
                }
            }
            
            
            tableView.beginUpdates()
            tableView.insertRows(at: [suggestedCellIndexPath!], with: UITableViewRowAnimation.top)
            tableView.endUpdates()
            
            tableView.scrollToRow(at: indexPath, at: UITableViewScrollPosition.top, animated: true)
        } else {
            
            if indexPath.row == selectedRow {
                
                tableView.beginUpdates()
                if suggestedCellIndexPath != nil{
                    rowPressed = false
                    selectedRow = nil
                    tableView.deleteRows(at: [suggestedCellIndexPath!], with: UITableViewRowAnimation.automatic)
                }
                tableView.endUpdates()
                
                tableView.scrollToRow(at: indexPath, at: UITableViewScrollPosition.top, animated: true)

            } else {
                tableView.beginUpdates()
                if suggestedCellIndexPath != nil{
                    tableView.deleteRows(at: [suggestedCellIndexPath!], with: UITableViewRowAnimation.automatic)
                    tableView.reloadData()
                }
                tableView.endUpdates()
                
                selectedRow = indexPath.row
                let section = indexPath.section
                suggestedCellIndexPath = IndexPath(row: selectedRow! + 1, section: section)
                
                //Build SuggestionItemArray of 6 Items
                if suggestedItemArray != nil {
                    suggestedItemArray?.removeAll(keepingCapacity: true)
                } else {
                    suggestedItemArray = []
                    suggestedItemArray?.reserveCapacity(6)
                    
                    //                for i in (0..<suggestedItemArray?.capacity){
                    //
                    //                }
                }

                
                tableView.scrollToRow(at: indexPath, at: UITableViewScrollPosition.top, animated: true)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if suggestedCellIndexPath != nil {
            if indexPath == suggestedCellIndexPath {
                return 80.0
            } else {
                return 68.0
            }
        } else {
            return 68.0

        }
    }
}
