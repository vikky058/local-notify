//
//  roundImageView.swift
//  Uber_Firebase_clone
//
//  Created by Vikky Chaudhary on 05/03/18.
//  Copyright © 2018 Vikky Chaudhary. All rights reserved.
//

import UIKit

class roundImageView: UIImageView {
    
    override func awakeFromNib() {
        setView()
    }
    
    func setView(){
        self.layer.cornerRadius = self.frame.width/2
        self.clipsToBounds = true
    }

}
