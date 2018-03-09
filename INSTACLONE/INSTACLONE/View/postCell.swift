//
//  postCell.swift
//  INSTACLONE
//
//  Created by Vikky Chaudhary on 09/02/18.
//  Copyright © 2018 Vikky Chaudhary. All rights reserved.
//

import UIKit
import Parse

class postCell: UITableViewCell {

   
    @IBOutlet weak var avaImg: UIImageView!
    @IBOutlet weak var username: UIButton!
    @IBOutlet weak var dateLbl: UILabel!
    
    @IBOutlet weak var postImg: UIImageView!
    @IBOutlet weak var likeBtn: UIButton!
    @IBOutlet weak var commentBtn: UIButton!
    @IBOutlet weak var moreBtn: UIButton!
    @IBOutlet weak var likeLbl: UILabel!
    @IBOutlet weak var detailLbl: UILabel!
    @IBOutlet weak var UUIDLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        likeBtn.setTitleColor(UIColor.clear, for: .normal)
        let width = UIScreen.main.bounds.width
        avaImg.translatesAutoresizingMaskIntoConstraints = false
        username.translatesAutoresizingMaskIntoConstraints = false
        dateLbl.translatesAutoresizingMaskIntoConstraints = false

        postImg.translatesAutoresizingMaskIntoConstraints = false

        likeBtn.translatesAutoresizingMaskIntoConstraints = false
        commentBtn.translatesAutoresizingMaskIntoConstraints = false
        moreBtn.translatesAutoresizingMaskIntoConstraints = false

        likeLbl.translatesAutoresizingMaskIntoConstraints = false
        detailLbl.translatesAutoresizingMaskIntoConstraints = false
        UUIDLbl.translatesAutoresizingMaskIntoConstraints = false

        let picture = width

        //constraints
        self.contentView.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-10-[ava(35)]-10-[pic(\(picture))]-5-[like(30)]",
            options: [], metrics: nil, views: ["ava":avaImg,"pic":postImg,"like":likeBtn]))

        self.contentView.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-5-[username]",
            options: [], metrics: nil, views: ["username":username]))

        self.contentView.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:[pic]-5-[comment(30)]",
            options: [], metrics: nil, views: ["pic":postImg ,"comment":commentBtn]))

        self.contentView.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-10-[date]",
            options: [], metrics: nil, views: ["date":dateLbl]))
      
        self.contentView.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:[pic]-10-[likes]",
            options: [], metrics: nil, views: ["pic":postImg,"likes":likeLbl]))
        
        self.contentView.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:[pic]-5-[more(30)]",
            options: [], metrics: nil, views: ["pic":postImg,"more":moreBtn]))
        
        self.contentView.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:[like]-5-[title]-5-|",
            options: [], metrics: nil, views: ["like":likeBtn,"title":detailLbl]))

        self.contentView.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-10-[ava(35)]-10-[username]-10-|",
            options: [], metrics: nil, views: ["ava":avaImg,"username":username]))

        self.contentView.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-0-[pic]-0-|",
            options: [], metrics: nil, views: ["pic":postImg]))

        self.contentView.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-15-[like(30)]-10-[likes]-20-[comment(30)]",
            options: [], metrics: nil, views: ["like":likeBtn,"likes":likeLbl,"comment":commentBtn]))

         self.contentView.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "H:[more(30)]-15-|",
            options: [], metrics: nil, views: ["more":moreBtn]))

         self.contentView.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-15-[title]-15-|",
            options: [], metrics: nil, views: ["title":detailLbl]))

         self.contentView.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "H:|[date]-10-|",
            options: [], metrics: nil, views: ["date":dateLbl]))
        
    // double tap
        let imgTap = UITapGestureRecognizer(target: self, action: #selector(postCell.pictap(recognizer:)))
        imgTap.numberOfTapsRequired = 2
        postImg.isUserInteractionEnabled = true
        postImg.addGestureRecognizer(imgTap)
        
    }
    
    
    @IBAction func likeBtn_click(_ sender: AnyObject) {
        
        let title = sender.title(for: UIControlState())
        
        if title == "unlike"{
            let object = PFObject(className: "likes")
            object["to"] = UUIDLbl.text
            object["by"] = PFUser.current()?.username
            object.saveInBackground { (success, error) in
                if success{
                print("liked")
                self.likeBtn.setImage(UIImage(named:"like.png"), for: UIControlState())
                self.likeBtn.setTitle("like", for: .normal)
                
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "liked"), object: nil)
                }
            }
        }else
        {
            let query = PFQuery(className: "likes")
            query.whereKey("to", equalTo: UUIDLbl.text)
            query.whereKey("by", equalTo: PFUser.current()?.username)
            query.findObjectsInBackground(block: { (objects, error) in
                if error == nil{
                    for object in objects!{
                        object.deleteInBackground(block: { (success, error) in
                            if success{
                                print("removed successfully postCell 137")
                               self.likeBtn.setImage(UIImage(named:"unlike.png"), for: UIControlState())
                                self.likeBtn.setTitle("unlike", for: .normal)
                                 NotificationCenter.default.post(name: NSNotification.Name(rawValue: "liked"), object: nil)
                            }
                        })
                    }
                }
            })
        }
    }
    
    @objc func pictap(recognizer:UIGestureRecognizer){
   
        let likepic = UIImageView(image:UIImage(named: "unlike.png"))
        likepic.frame.size.width = postImg.frame.size.width/1.2
        likepic.frame.size.height = postImg.frame.size.height/1.2
        likepic.center = postImg.center
        likepic.alpha = 0.8
        self.addSubview(likepic)
        UIView.animate(withDuration: 0.5) {
            likepic.alpha = 0
            likepic.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        }
       
        let title = likeBtn.title(for: UIControlState())
        if title == "unlike"{
            let object = PFObject(className: "likes")
            object["to"] = UUIDLbl.text
            object["by"] = PFUser.current()?.username
            object.saveInBackground { (success, error) in
                if success{
                    print("liked")
                    self.likeBtn.setImage(UIImage(named:"like.png"), for: UIControlState())
                    self.likeBtn.setTitle("like", for: .normal)
                    
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "liked"), object: nil)
                }
            }
        }
    }
    
}














