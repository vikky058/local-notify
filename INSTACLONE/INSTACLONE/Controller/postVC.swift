//
//  postVC.swift
//  INSTACLONE
//
//  Created by Vikky Chaudhary on 09/02/18.
//  Copyright © 2018 Vikky Chaudhary. All rights reserved.
//

import UIKit
import Parse

var postuuid = [String]()

class postVC: UITableViewController {

    var avaArray = [PFFile]()
    var dateArray = [Date]()
    var usernameArray = [String]()
    var pic = [PFFile]()
    var uuidArray = [String]()
    var titleArray = [String]()
    
    override func viewDidLoad() {
    super.viewDidLoad()
    
    //back btn
        navigationItem.title = "Photo"
        navigationItem.hidesBackButton = true
        let backBtn = UIBarButtonItem(title: "back", style: .plain, target: self, action: #selector(postVC.backClk(sender:)) )
        navigationItem.leftBarButtonItem = backBtn
    
    //hold like notification
        NotificationCenter.default.addObserver(self, selector: #selector(postVC.refresh(notification:)), name: NSNotification.Name(rawValue: "liked"), object: nil)
        
    //swipe
        let postSwipe = UISwipeGestureRecognizer(target: self, action: #selector(postVC.backClk(sender:)))
        postSwipe.direction = .right
        self.view.isUserInteractionEnabled = true
        self.view.addGestureRecognizer(postSwipe)
        
    // cell height
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 500
        
    //query
        let query = PFQuery(className: "posts")
        query.whereKey("uuid", equalTo: postuuid.last)
        query.findObjectsInBackground { (objects, error) in
            if error == nil{
                
                self.avaArray.removeAll(keepingCapacity: true)
                self.dateArray.removeAll(keepingCapacity: true)
                self.usernameArray.removeAll(keepingCapacity: true)
                self.pic.removeAll(keepingCapacity: true)
                self.uuidArray.removeAll(keepingCapacity: true)
                self.titleArray.removeAll(keepingCapacity: true)
                
                for object in objects!{
                    self.avaArray.append(object.value(forKey: "ava") as! PFFile)
                    self.usernameArray.append(object.value(forKey: "username") as! String)
                  
                    print("hi \(object.value(forKey: "username") as! String)")
                    
                    self.pic.append(object.value(forKey: "pic") as! PFFile)
                    self.uuidArray.append(object.value(forKey: "uuid") as! String)
                    self.titleArray.append(object.value(forKey: "title") as! String)
                    self.dateArray.append(object.createdAt!)
                }
                self.tableView.reloadData()
            }
        }
    }
  
    //Mark: username click
    @IBAction func usernameBtn_Click(_ sender: AnyObject) {
        let i = sender.layer.value(forKey: "index") as! IndexPath
        let cell = tableView.cellForRow(at: i) as! postCell
        
        if cell.username.titleLabel?.text == PFUser.current()?.username {
            let home = self.storyboard?.instantiateViewController(withIdentifier: "homeVC") as! homeVC
            self.navigationController?.pushViewController(home, animated: true)
        }
        else{
            guestname.append(cell.username.titleLabel!.text!)
            let guest = self.storyboard?.instantiateViewController(withIdentifier: "guestVC") as! guestVC
            self.navigationController?.pushViewController(guest, animated: true)
        }
    }
    
    //Mark: comment button click
    @IBAction func comment_Click(_ sender: AnyObject) {
        let i = sender.layer.value(forKey: "index") as! IndexPath
        let cell = tableView.cellForRow(at: i) as! postCell
        commentuuid.append(cell.UUIDLbl.text!)
        commentowner.append(cell.username.titleLabel!.text!)
        let comment = self.storyboard?.instantiateViewController(withIdentifier: "commentVC") as! commentVC
        self.navigationController?.pushViewController(comment, animated: true)
        
    }
    
    @objc func backClk(sender:UIBarButtonItem){
        self.navigationController?.popViewController(animated: true)
        postuuid.removeLast()
    }
   
    @objc func refresh(notification:NSNotification){
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(postuuid.count)
        print(usernameArray.last)
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! postCell
        cell.username.setTitle(usernameArray.last, for: .normal)
        cell.username.sizeToFit()
        cell.detailLbl.text = titleArray.last
        cell.detailLbl.sizeToFit()
        cell.UUIDLbl.text = uuidArray.last
        
        avaArray.last?.getDataInBackground(block: { (data, error) in
            if error == nil{
                cell.avaImg.image = UIImage(data: data!)
            }
        })
       
        pic.last?.getDataInBackground(block: { (data, error) in
            if error == nil {
                cell.postImg.image = UIImage(data: data!)
            }
        })
        
        //calculate date n time
//        let from = dateArray.last
//        let now = Date()
//        let components:Set<Calendar.Component> = [.second, .minute, .hour, .day, .weekOfMonth]
//        let difference = Calendar.current.dateComponents(components, from: from as! Date, to: now)
//
//        if difference.second! <= 0 {
//            cell.dateLbl.text = "Now"
//        }
//        if difference.second! > 0 && difference.minute! == 0{
//            cell.dateLbl.text = "\(difference.second)s"
//        }
//        if difference.minute! > 0 && difference.hour! == 0{
//            cell.dateLbl.text = "\(difference.minute)m"
//        }
//        if difference.hour! > 0 && difference.day! == 0{
//            cell.dateLbl.text = "\(difference.hour)m"
//        }
//        if difference.day! > 0 && difference.weekOfMonth == 0{
//            cell.dateLbl.text = "\(difference.day)d"
//        }
//        if difference.month! > 0 {
//            cell.dateLbl.text = "\(difference.minute)w"
//        }
       
//check number of likes
        let query22 = PFQuery(className: "likes")
        query22.whereKey("to", equalTo: cell.UUIDLbl.text)
        query22.countObjectsInBackground { (count, error) in
            if error == nil{
                cell.likeLbl.text = "\(count)"
            }else{
                print(error?.localizedDescription)
            }
        }

//check current user like or not
         let query23 = PFQuery(className: "likes")
        query23.whereKey("to", equalTo: cell.UUIDLbl.text)
        query23.whereKey("by", equalTo: PFUser.current()!.username)
        query23.countObjectsInBackground { (count, error) in
            if count == 0{
                cell.likeBtn.setImage(UIImage(named:"unlike.png"), for: UIControlState())
                cell.likeBtn.setTitle("unlike", for: UIControlState())
                
            }else{
                cell.likeBtn.setImage(UIImage(named:"like.png"), for: UIControlState())
                cell.likeBtn.setTitle("like", for: UIControlState())
                
            }
        }
        //assign index for username click
        cell.username.layer.setValue(indexPath, forKey: "index")
        cell.commentBtn.layer.setValue(indexPath, forKey: "index")
        
        return cell
    }
}


















