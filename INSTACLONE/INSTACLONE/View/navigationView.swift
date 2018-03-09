//
//  navigationView.swift
//  INSTACLONE
//
//  Created by Vikky Chaudhary on 10/02/18.
//  Copyright © 2018 Vikky Chaudhary. All rights reserved.
//

import UIKit

class navigationView: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        self.navigationBar.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.navigationBar.barTintColor = #colorLiteral(red: 0.766900867, green: 0.1818033259, blue: 1, alpha: 1)
        self.navigationBar.isTranslucent = false
    }
//    override func preferredStatusBarStyle() -> UIStatusBarStyle {
//        return UIStatusBarStyle.lightContent
//    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
}
