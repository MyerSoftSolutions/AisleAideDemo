//
//  AddMoreItemsViewController.swift
//  AisleAideDemo
//
//  Created by Joel Myers on 11/3/16.
//  Copyright © 2016 MyerSoft Solutions. All rights reserved.
//

import UIKit

class AddMoreItemsViewController: AisleAideSetupViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addMoreItems(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "ProdGrpCollectionViewController") as! ProdGrpCollectionViewController
        controller.lyle = self.lyle
        controller.prodGrpArray = (self.lyle?.currentStore?.aisleList.getAllProdGrps())!
        var controllers = self.navigationController?.viewControllers
        controllers?.popLast()
        controllers?.popLast()
        controllers?.popLast()
        controllers?.append(controller)
        self.navigationController?.setViewControllers(controllers!, animated: false)
        
        self.navigationController?.popViewController(animated: true)

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MoreItemsSegue" {
            let vc = segue.destination as! ItemListViewController
            vc.lyle = self.lyle
            

        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
