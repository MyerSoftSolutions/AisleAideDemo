//
//  AisleAideSetupViewController.swift
//  AisleAideDemo
//
//  Created by Joel Myers on 10/5/16.
//  Copyright © 2016 MyerSoft Solutions. All rights reserved.
//

import UIKit

class AisleAideSetupViewController: UIViewController {
    
    var lyle : Lyle?
    var backBtn : UIBarButtonItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    func createCustomBackButton(btnTitle: String) {
        self.backBtn = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.Done, target: self, action: #selector(AisleAideSetupViewController.navigationBackButtonClicked))
        self.navigationItem.leftBarButtonItem = self.backBtn
    }
    
    func navigationBackButtonClicked(sender: UIBarButtonItem) {
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
