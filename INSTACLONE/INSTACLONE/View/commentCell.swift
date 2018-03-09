//
//  commentCell.swift
//  INSTACLONE
//
//  Created by Vikky Chaudhary on 12/02/18.
//  Copyright © 2018 Vikky Chaudhary. All rights reserved.
//

import UIKit

class commentCell: UITableViewCell {

    @IBOutlet weak var avaImg: UIImageView!
    @IBOutlet weak var usernameBtn: UIButton!
    @IBOutlet weak var commentlbl: UILabel!
    @IBOutlet weak var timelbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        avaImg.translatesAutoresizingMaskIntoConstraints = false
        usernameBtn.translatesAutoresizingMaskIntoConstraints = false
        commentlbl.translatesAutoresizingMaskIntoConstraints = false
        timelbl.translatesAutoresizingMaskIntoConstraints = false
        
        self.contentView.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-10-[avaimg(40)]",
            options: [], metrics: nil, views: ["avaimg":avaImg]))
        
        self.contentView.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-5-[username]-(-2)-[comment]-5-|",
            options: [], metrics: nil, views: ["username":usernameBtn,"comment":commentlbl]))
        
        self.contentView.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-5-[time]",
            options: [], metrics: nil, views: ["time":timelbl]))
        
        self.contentView.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-10-[avaimg(40)]-13-[comment]-20-|",
            options: [], metrics:nil, views: ["avaimg":avaImg,"comment":commentlbl]))
       
        self.contentView.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "H:[avaimg]-13-[username]",
            options: [], metrics: nil, views: ["avaimg":avaImg,"username":user]))
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
