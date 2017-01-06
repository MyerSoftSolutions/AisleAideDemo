//
//  ItemListViewController.swift
//  AisleAideDemo
//
//  Created by Joel Myers on 11/1/16.
//  Copyright © 2016 MyerSoft Solutions. All rights reserved.
//

import UIKit

class ItemTableCell : PKSwipeTableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var aisleLabel: UILabel!
    @IBOutlet weak var separatorView: UIView!
    
    var deleteBtn : UIButton?
    var hasBeenRetrieved : Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.addRightViewInCell()
    }
    
    func addRightViewInCell() {
        //Create a view that will display when user swipe the cell in right
        let viewCall = UIView()
        viewCall.backgroundColor = UIColor.orange
        viewCall.frame = CGRect(x: 0, y: 0, width: 68.0, height: 68.0)
        
        let bigBtn = UIButton(type: UIButtonType.custom)
        bigBtn.frame = viewCall.frame
        bigBtn.backgroundColor = UIColor.clear
        self.deleteBtn = bigBtn
        viewCall.addSubview(bigBtn)
        
        //Add a button to perform the action when user will tap on call and add a image to display
        let btnCall = UIImageView(image: UIImage(named: "checkmark"))
        btnCall.frame = bigBtn.frame
        btnCall.backgroundColor = UIColor.orange
        
        bigBtn.addSubview(btnCall)
        
        //Call the super addRightOptions to set the view that will display while swiping
        super.addRightOptionsView(viewCall)
    }
    
    override func layoutSubviews() {
        if hasBeenRetrieved {
//            newMsgView.isHidden = true
            //            titleLabel.textColor = UIColor.cityCoolInboxGray()
        }
        //        disclosureIcon.transform = CGAffineTransform(rotationAngle: (180.0 * CGFloat(M_PI)) / 180.0)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

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

class ItemListViewController: AisleAideSetupViewController, PKSwipeCellDelegateProtocol,UITableViewDataSource, UITableViewDelegate, RetrievedItemsModalDelegate {
    var itemArray : [Item] = []
    var rowPressed = false
    var selectedRow : Int?
    var alsoOnThisArray, oneAisleOverArray : [Item]?
    var suggestedCellIndexPath : IndexPath?
    var suggestedItemArray : [Item]?
    
    @IBOutlet weak var itemsCountLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var salesBtn: UIButton!
    @IBOutlet weak var couponBtn: UIButton!
    @IBOutlet weak var exploreBtn: UIButton!

    fileprivate var oldStoredCell : ItemTableCell?
    @IBOutlet weak var scoredItemsBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.createCustomBackButton("+Add Item")
        self.title = "My ItemList"
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 68.0

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

        if (Lyle.defaultHelper.currentItemList?.retrievedItemsArray.count)! == 0 {
            self.scoredItemsBtn.isHidden = true
        } else {
            
            self.scoredItemsBtn.isHidden = false
            if Lyle.defaultHelper.currentItemList?.retrievedItemsArray.count == 1 {
                self.scoredItemsBtn.setTitle("1 Item Scored", for: .normal)
            } else {
                self.scoredItemsBtn.setTitle("\((Lyle.defaultHelper.currentItemList?.retrievedItemsArray.count)!) Items Scored", for: .normal)
            }

        }
        tableView.reloadData()

    }
    
    //MARK: SwipeCell Delegate Methods
    func swipeBeginInCell(_ cell: PKSwipeTableViewCell) {
        
        oldStoredCell = cell as? ItemTableCell
    }
    
    func swipeDoneOnPreviousCell() -> PKSwipeTableViewCell? {
        guard let cell = oldStoredCell else {
            return nil
        }
        return cell
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
    
    func updateItemList(_ item: Item){
        self.itemArray = (Lyle.defaultHelper.currentItemList?.itemArray)!
        self.itemArray.sort(by: {$0.aisle!.aisleNumber! < $1.aisle!.aisleNumber!})
        self.itemsCountLabel.text = String(format:"Items: %d", self.itemArray.count)
        
        if (Lyle.defaultHelper.currentItemList?.retrievedItemsArray.count)! == 0 {
            self.scoredItemsBtn.isHidden = true
        } else {
            
            self.scoredItemsBtn.isHidden = false
            if Lyle.defaultHelper.currentItemList?.retrievedItemsArray.count == 1 {
                self.scoredItemsBtn.setTitle("1 Item Scored", for: .normal)
            } else {
                self.scoredItemsBtn.setTitle("\((Lyle.defaultHelper.currentItemList?.retrievedItemsArray.count)!) Items Scored", for: .normal)
            }
            
        }

        
        self.tableView.reloadData()
        
        //Receive the Item, and add it into 
        
        if let invalidView = UIApplication.shared.keyWindow!.viewWithTag(1000) {
            invalidView.removeFromSuperview()
        }
        
    }
    
    func nixModal() {
        if let invalidView = UIApplication.shared.keyWindow!.viewWithTag(1000) {
            invalidView.removeFromSuperview()
        }
    }
    
    func presentRetrievedItems() {
        if let invalidView = UIApplication.shared.keyWindow!.viewWithTag(1000) {
            invalidView.removeFromSuperview()
        }
        
        let invalidSignInModal = RetrievedItemsModalController()
        invalidSignInModal.modalDelegate = self
        invalidSignInModal.view.tag = 1000
        
        UIApplication.shared.keyWindow!.addSubview(invalidSignInModal.view)
        self.addChildViewController(invalidSignInModal)
        invalidSignInModal.didMove(toParentViewController: self)
        
    }

    
    @IBAction func showRetrievedItems(_ sender: UIButton) {
        self.presentRetrievedItems()
    }
    //MARK: Retrieve Item from TableView
    func itemRetrieved (_ sender: UIButton) {
        let cell  = sender.superview!.superview!.superview!.superview as! ItemTableCell
        
        let idxPath = tableView.indexPath(for: cell)
        //Remove item from itemArray and add to currentItemList.retrievedItem
        let item = self.itemArray[idxPath!.row]
        Lyle.defaultHelper.currentItemList?.addRetrievedItem(item)
        self.itemArray.remove(at: idxPath!.row)
        Lyle.defaultHelper.currentItemList?.itemArray = self.itemArray
        self.itemsCountLabel.text = "Items: \(self.itemArray.count)"
        
        if Lyle.defaultHelper.currentItemList?.retrievedItemsArray.count == 1 {
            self.scoredItemsBtn.setTitle("1 Item Scored", for: .normal)
        } else {
            self.scoredItemsBtn.setTitle("\((Lyle.defaultHelper.currentItemList?.retrievedItemsArray.count)!) Items Scored", for: .normal)
        }
        self.scoredItemsBtn.isHidden = false
        
//        items.remove(at: idxPath!.row)
        tableView.deleteRows(at: [idxPath!], with: .fade)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: TABLEVIEW DATASOURCE METHODS
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
                cell.delegate = self

                let item = self.itemArray[indexPath.row]
                cell.nameLabel.text = item.name
                cell.aisleLabel.text = "\(item.aisleNum!)"
                print(cell.aisleLabel.text!)
                cell.deleteBtn?.addTarget(self, action: #selector(ItemListViewController.itemRetrieved), for: .touchUpInside)

                return cell


            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "SuggestionsTableCell", for: indexPath) as! SuggestionsTableCell
                cell.parentController = self
                cell.itemArray = self.suggestedItemArray!
                return cell

            }
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ItemTableCell", for: indexPath) as! ItemTableCell
            cell.delegate = self

            let item = self.itemArray[indexPath.row]
            cell.nameLabel.text = item.name
            cell.aisleLabel.text = "\(item.aisleNum!)"
            print(cell.aisleLabel.text!)
            cell.deleteBtn?.addTarget(self, action: #selector(ItemListViewController.itemRetrieved), for: .touchUpInside)

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
