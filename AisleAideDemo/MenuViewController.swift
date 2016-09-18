//
//  MenuViewController.swift
//  AisleAideDemo
//
//  Created by Joel Myers on 9/13/16.
//  Copyright © 2016 MyerSoft Solutions. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    @IBOutlet weak var leftStackView: UIStackView!
    @IBOutlet weak var leftWidthCon: NSLayoutConstraint!
    
    @IBOutlet weak var rightStackView: UIStackView!
    @IBOutlet weak var rightWidthCon: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()

        let screenSize: CGRect = UIScreen.mainScreen().bounds
        self.leftWidthCon.constant = screenSize.width/2 - 12
        self.rightWidthCon.constant = self.leftWidthCon.constant
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
