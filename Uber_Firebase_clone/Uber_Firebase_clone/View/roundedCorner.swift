//
//  roundedCorner.swift
//  Uber_Firebase_clone
//
//  Created by Vikky Chaudhary on 05/03/18.
//  Copyright © 2018 Vikky Chaudhary. All rights reserved.
//

import UIKit

class roundedCorner: UIView {

    override func awakeFromNib() {
       setupView()
    }
    func setupView(){
        self.layer.cornerRadius = 5.0
        self.layer.shadowOpacity = 0.3
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowRadius = 5.0
        self.layer.shadowOffset = CGSize(width: 0, height: 5)
    }

}
