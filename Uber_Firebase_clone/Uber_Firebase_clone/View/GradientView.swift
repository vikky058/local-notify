//
//  GradientView.swift
//  Uber_Firebase_clone
//
//  Created by Vikky Chaudhary on 05/03/18.
//  Copyright © 2018 Vikky Chaudhary. All rights reserved.
//

import UIKit

class GradientView: UIView {

    let gradient = CAGradientLayer()
    
    override func awakeFromNib() {
        setupGradientView()
    }
    
    func setupGradientView(){
        gradient.frame = self.frame
        gradient.colors = [UIColor.white.cgColor,UIColor.init(white: 1.0, alpha: 0.0).cgColor]
        gradient.startPoint = CGPoint.zero
        gradient.endPoint = CGPoint(x: 0, y: 1)
        gradient.locations = [0.8,1.0]                      //[80% ,100 %]
        self.layer.addSublayer(gradient)
    }

}
