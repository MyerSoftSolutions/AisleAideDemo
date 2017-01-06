//
//  RetrievedItemsTableController.swift
//  AisleAideDemo
//
//  Created by Joel Myers on 12/16/16.
//  Copyright © 2016 MyerSoft Solutions. All rights reserved.
//

import UIKit

protocol RetrievedItemsDelegate {
    func itemReAdded(_ item: Item)
}

class RetrievedItemsTableController: UITableViewController {
        
    var delegate : RetrievedItemsDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.layer.cornerRadius = 3.0
        
        
        self.tableView.separatorStyle = .none
        self.tableView.register(UINib(nibName: "RetrievedItemTableViewCell", bundle: nil), forCellReuseIdentifier: "RetrievedItemTableViewCell")
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44.0
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (Lyle.defaultHelper.currentItemList?.retrievedItemsArray.count)!
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RetrievedItemTableViewCell")! as! RetrievedItemTableViewCell
        cell.selectionStyle = .none
        
        let Item = Lyle.defaultHelper.currentItemList?.retrievedItemsArray[indexPath.row]
        cell.nameLabel.text = Item?.name
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "TimeRowPressed"), object: indexPath.row)
        
        let item = Lyle.defaultHelper.currentItemList?.retrievedItemsArray[indexPath.row]
        let alertController = UIAlertController(title: "Re-Add \((item?.name)!) ", message: "to cart?", preferredStyle: UIAlertControllerStyle.alert)
        
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default)
        {
            (result : UIAlertAction) -> Void in
            var count = 0
            for itm in (Lyle.defaultHelper.currentItemList?.retrievedItemsArray)!{
                if Lyle.defaultHelper.currentItemList?.retrievedItemsArray[count] == itm {
                    Lyle.defaultHelper.currentItemList?.retrievedItemsArray.remove(at: count)
                    Lyle.defaultHelper.currentItemList?.itemArray.append(itm)
                    break
                } else {
                    count += 1
                }
            }
            self.delegate?.itemReAdded((item)!)
             alertController.dismiss(animated: true, completion: nil)
        }
        
        let noAction = UIAlertAction(title: "No", style: UIAlertActionStyle.default)
        {
            (result : UIAlertAction) -> Void in
            alertController.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(noAction)
        alertController.addAction(okAction)

        self.present(alertController, animated: true, completion: nil)
        
        
        
    }
}

protocol RetrievedItemsModalDelegate {
    func updateItemList(_ item: Item)
    func nixModal()
}

class RetrievedItemsModalController : UIViewController, RetrievedItemsDelegate, UIGestureRecognizerDelegate{
    var retrievedItemsTableView : UIView?
    var retrievedItemsTableController : RetrievedItemsTableController?
    var modalDelegate : RetrievedItemsModalDelegate?
    var selectedIdx : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        modalPresentationStyle = .overCurrentContext
        self.view.backgroundColor = UIColor.init(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.4)
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(RetrievedItemsModalController.dismissModal))
        tap.delegate = self
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        
        retrievedItemsTableController = RetrievedItemsTableController(nibName: "RetrievedItemsTableController", bundle: nil)
        retrievedItemsTableController?.delegate = self
        self.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        
        
        // Do any additional setup after loading the view.
    }
  
    func itemReAdded(_ item: Item){
        self.modalDelegate?.updateItemList(item)
    }
    
    func dismissModal() {
        self.modalDelegate?.nixModal()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        retrievedItemsTableView = retrievedItemsTableController?.view
        
        
        retrievedItemsTableView?.frame = CGRect(x: 17.0, y: 40.0, width: 210, height: 219)
        
        retrievedItemsTableView!.center = self.view.center
        
        self.view.addSubview(retrievedItemsTableView!)
        self.addChildViewController(retrievedItemsTableController!)
        retrievedItemsTableController?.didMove(toParentViewController: self)
        
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if (touch.view?.isDescendant(of: self.retrievedItemsTableView!))!{
            return false
        }
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
