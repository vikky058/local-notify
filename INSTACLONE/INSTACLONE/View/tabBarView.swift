//
//  tabBarView.swift
//  INSTACLONE
//
//  Created by Vikky Chaudhary on 10/02/18.
//  Copyright © 2018 Vikky Chaudhary. All rights reserved.
//

import UIKit

class tabBarView: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBar.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.tabBar.barTintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        tabBar.isTranslucent = true
    }
    
}
