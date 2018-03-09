//
//  followersCell.swift
//  INSTACLONE
//
//  Created by Vikky Chaudhary on 05/02/18.
//  Copyright © 2018 Vikky Chaudhary. All rights reserved.
//

import UIKit
import Parse

class followersCell: UITableViewCell {

   
    
    @IBOutlet weak var avaImg: UIImageView!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var followingBtn: UIButton!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func followBtn_click(_ sender: Any) {
        let title = followingBtn.title(for: .normal)
        print(title)
        if title == "FOLLOW"
        {
            let object = PFObject(className: "follow")
            object["follower"] = PFUser.current()?.username
            object["following"] = userNameLbl.text
            object.saveInBackground(block: { (success, error) in
                if success{
                    self.followingBtn.setTitle("FOLLOWING", for: .normal)
                    self.followingBtn.layer.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
                }else{
                    print(error?.localizedDescription)
                }
            })
            
        }else{
            let query = PFQuery(className: "follow")
            query.whereKey("follower", equalTo: PFUser.current()?.username)
            query.whereKey("following", equalTo: userNameLbl.text)
            query.findObjectsInBackground(block: { (objects, error) in
                if error == nil{
                    for object in objects!{
                        object.deleteInBackground(block: { (success, error) in
                            if success{
                                self.followingBtn.setTitle("FOLLOW", for: .normal)
                                self.followingBtn.layer.backgroundColor = #colorLiteral(red: 0.7159407907, green: 0.7232709391, blue: 0.7144392357, alpha: 1)
                            }else{
                                print(error?.localizedDescription)
                            }
                        })
                    }
                }else{
                    print(error?.localizedDescription)
                }
            })
        }
        
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
