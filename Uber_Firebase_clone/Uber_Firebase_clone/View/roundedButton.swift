//
//  roundedButton.swift
//  Uber_Firebase_clone
//
//  Created by Vikky Chaudhary on 05/03/18.
//  Copyright © 2018 Vikky Chaudhary. All rights reserved.
//

import UIKit

class roundedButton: UIButton {

    override func awakeFromNib() {
        setUpView()
    }
    
    func setUpView(){
        self.layer.cornerRadius = 15
        self.layer.shadowRadius = 10
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOpacity = 0.3
        self.layer.shadowOffset = CGSize(width: 0, height: 5)
    }
}
