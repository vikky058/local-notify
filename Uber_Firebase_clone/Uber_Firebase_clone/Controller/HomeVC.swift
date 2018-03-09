//
//  ViewController.swift
//  Uber_Firebase_clone
//
//  Created by Vikky Chaudhary on 28/02/18.
//  Copyright © 2018 Vikky Chaudhary. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {

    @IBOutlet weak var slider: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        slider.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
    }
}

