//
//  roundedView.swift
//  Uber_Firebase_clone
//
//  Created by Vikky Chaudhary on 05/03/18.
//  Copyright © 2018 Vikky Chaudhary. All rights reserved.
//

import UIKit

class roundedView: UIView {
    
    @IBInspectable var borderColor : UIColor?{
        didSet{
            roundedView()
        }
    }
    override func awakeFromNib() {
        
    }

    func roundedView(){
        self.layer.cornerRadius = self.frame.width/2
        self.clipsToBounds = true
        self.layer.borderColor = borderColor?.cgColor
        self.layer.borderWidth = 1
    }
    
}
