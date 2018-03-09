//
//  homeHeaderView.swift
//  INSTACLONE
//
//  Created by Vikky Chaudhary on 04/02/18.
//  Copyright © 2018 Vikky Chaudhary. All rights reserved.
//

import UIKit
import Parse

class homeHeaderView: UICollectionReusableView {
    
    @IBOutlet weak var avaImg: UIImageView!
    @IBOutlet weak var fullnameLbl: UILabel!
  //  @IBOutlet weak var webTxt: UITextView!
  //  @IBOutlet weak var bioLbl: UITextView!
    @IBOutlet weak var webTxt: UILabel!
    @IBOutlet weak var bioLbl: UILabel!
    
    @IBOutlet weak var posts: UILabel!
    @IBOutlet weak var followers: UILabel!
    @IBOutlet weak var following: UILabel!

    @IBOutlet weak var followingCount: UILabel!
    @IBOutlet weak var followersCount: UILabel!
    @IBOutlet weak var postCount: UILabel!
    
    @IBOutlet weak var editProfileBtn: UIButton!
    
    
    
    @IBAction func editProfileBtn_click(_ sender: Any) {
        
    }
    
    //follow btn click from guest controller
    @IBAction func followBtn_click(_ sender: Any) {
        let title = editProfileBtn.title(for: .normal)
        print(title)
        if title == "FOLLOW"
        {
            let object = PFObject(className: "follow")
            object["follower"] = PFUser.current()?.username
            object["following"] = guestname.last
            object.saveInBackground(block: { (success, error) in
                if success{
                    self.editProfileBtn.setTitle("FOLLOWING", for: .normal)
                    self.editProfileBtn.layer.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
                }else{
                    print(error?.localizedDescription)
                }
            })
            
        }else{
            let query = PFQuery(className: "follow")
            query.whereKey("follower", equalTo: PFUser.current()?.username)
            query.whereKey("following", equalTo: guestname.last)
            query.findObjectsInBackground(block: { (objects, error) in
                if error == nil{
                    for object in objects!{
                        object.deleteInBackground(block: { (success, error) in
                            if success{
                                self.editProfileBtn.setTitle("FOLLOW", for: .normal)
                                self.editProfileBtn.layer.backgroundColor = #colorLiteral(red: 0.7159407907, green: 0.7232709391, blue: 0.7144392357, alpha: 1)
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
}
