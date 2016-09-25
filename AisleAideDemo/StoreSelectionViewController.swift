//
//  StoreSelectionViewController.swift
//  AisleAideDemo
//
//  Created by Joel Myers on 9/13/16.
//  Copyright © 2016 MyerSoft Solutions. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class StoreSelectionCell : UITableViewCell {
    
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var plazaNameLabel: UILabel!
    @IBOutlet weak var streetPhoneLabel: UILabel!
    @IBOutlet weak var timeClosingLabel: UILabel!
}

class StoreSelectionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var storeTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        storeTableView.separatorStyle = .None
        storeTableView.rowHeight = UITableViewAutomaticDimension
        storeTableView.estimatedRowHeight = 114.0

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("StoreSelectionCell", forIndexPath: indexPath) as! StoreSelectionCell
        cell.selectionStyle = .None
        
        if indexPath.row == 0{
            cell.nameLabel.text = "Kroger"
            cell.likesLabel.text = "15"
            cell.logoImageView.image = UIImage(named: "kroger")
            cell.plazaNameLabel.text = "Moreland Shopping Plaza"
            cell.streetPhoneLabel.text = "1160 Moreland Ave SE | (404)-624-8001"
            cell.timeClosingLabel.text = "Closing soon: 1:00 AM"
        } else {
            cell.nameLabel.text = "Corner Foods"
            cell.likesLabel.text = "9"
            cell.logoImageView.image = UIImage(named: "kroger")
            cell.plazaNameLabel.text = "Cascade Promenade"
            cell.streetPhoneLabel.text = "1160 Moreland Ave SE | (404)-734-8185"
            cell.timeClosingLabel.text = "Opens at 7:00 AM"
        }

        return cell
    }
   
    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        
//    }

}
