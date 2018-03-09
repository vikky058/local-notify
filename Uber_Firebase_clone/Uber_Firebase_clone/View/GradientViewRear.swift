//
//  GradientViewRear.swift
//  Uber_Firebase_clone
//
//  Created by Vikky Chaudhary on 05/03/18.
//  Copyright © 2018 Vikky Chaudhary. All rights reserved.
//

import UIKit

class GradientViewRear: UIView {

    @IBInspectable var topColor = #colorLiteral(red: 0.2901960784, green: 0.3019607843, blue: 0.8470588235, alpha: 1) {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable var bottomColor = #colorLiteral(red: 0.1725490196, green: 0.831372549, blue: 0.8470588235, alpha: 1) {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    override func layoutSubviews() {
        let gradiant = CAGradientLayer()
        gradiant.colors = [topColor.cgColor , bottomColor.cgColor]
        gradiant.startPoint = CGPoint(x: 0, y: 0)
        gradiant.endPoint = CGPoint(x: 1, y: 1)
        gradiant.frame = self.bounds
        self.layer.insertSublayer(gradiant, at: 0)
    }

}
