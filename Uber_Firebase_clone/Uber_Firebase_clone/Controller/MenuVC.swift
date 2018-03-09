//
//  MenuVC.swift
//  Uber_Firebase_clone
//
//  Created by Vikky Chaudhary on 05/03/18.
//  Copyright © 2018 Vikky Chaudhary. All rights reserved.
//

import UIKit

class MenuVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 50
    }
    
    
    @IBAction func login_clicked(_ sender: Any) {
        performSegue(withIdentifier: "tologin", sender: nil)
    }
    
}
