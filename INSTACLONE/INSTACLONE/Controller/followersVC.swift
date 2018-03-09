//
//  followersVC.swift
//  INSTACLONE
//
//  Created by Vikky Chaudhary on 05/02/18.
//  Copyright © 2018 Vikky Chaudhary. All rights reserved.
//

import UIKit
import Parse

var showTap = String()
var user = String()

class followersVC: UITableViewController {
    
    var username = [String]()
    var avaarray = [PFFile]()
    var follower = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = showTap.uppercased()
        
        if showTap == "follower"{
            loadFollower()
        }
        if showTap == "following"{
            loadFollowing()
        }
    }

    func loadFollower(){
        let followQuery = PFQuery(className: "follow")
        followQuery.whereKey("following", equalTo: user)
        followQuery.findObjectsInBackground { (objects, error) in
            if error == nil{
                self.follower.removeAll(keepingCapacity: false)
                for object in objects!{
                  self.follower.append(object["follower"] as! String)
                }
            let newQuery = PFUser.query()
            newQuery?.whereKey("username", containedIn: self.follower)
            newQuery?.addAscendingOrder("createdAt")
                newQuery?.findObjectsInBackground(block: { (objects, error) in
                    if error == nil{
                        self.username.removeAll(keepingCapacity: false)
                        self.avaarray.removeAll(keepingCapacity: false)
                        
                        for object in objects!{
                            self.username.append(object["username"] as! String)
                            self.avaarray.append(object["ava"] as! PFFile)
                            self.tableView.reloadData()
                        }
                    }else{
                        print(error!.localizedDescription)
                    }
                })
                
            }
        }
    
    }
    
    func loadFollowing(){
        let followingQuery = PFQuery(className: "follow")
        followingQuery.whereKey("follower", equalTo: user)
        followingQuery.findObjectsInBackground { (objects, error) in
            if error == nil{
                self.follower.removeAll(keepingCapacity: false)
                for object in objects!{
                    self.follower.append(object["following"] as! String)
                }
                
                let query1 = PFUser.query()
                query1?.whereKey("username", containedIn: self.follower)
                query1?.addAscendingOrder("createdAt")
                query1?.findObjectsInBackground(block: { (objects, error) in
                    if error == nil{
                        self.username.removeAll(keepingCapacity: false)
                        self.avaarray.removeAll(keepingCapacity: false)
                        
                        for object in objects! {
                            self.username.append(object["username"] as! String)
                            self.avaarray.append(object["ava"] as! PFFile)
                            self.tableView.reloadData()
                        }
                    }else{
                        print(error?.localizedDescription)
                    }
                })
            }else{
                print(error?.localizedDescription)
            }
        }
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return username.count
    }

    //Mark: show tableview for follower or following
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! followersCell
        cell.userNameLbl.text = username[indexPath.row]
        avaarray[indexPath.row].getDataInBackground { (data, error) in
            if error == nil{
                cell.avaImg.image = UIImage(data: data!)
            }else{
                print(error?.localizedDescription)
            }
        }
            let query1 = PFQuery(className: "follow")
            query1.whereKey("follower", equalTo: PFUser.current()?.username)
            query1.whereKey("following", equalTo: cell.userNameLbl.text)
            query1.countObjectsInBackground { (count, error) in
            if error == nil{
                if count == 0{
                    cell.followingBtn.setTitle("FOLLOW", for: .normal)
                    cell.followingBtn.backgroundColor = #colorLiteral(red: 0.7159407907, green: 0.7232709391, blue: 0.7144392357, alpha: 1)
                }
                if count == 1{
                    cell.followingBtn.setTitle("FOLLOWING", for: .normal)
                    cell.followingBtn.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
                }
            }
        }
        if cell.userNameLbl.text == PFUser.current()?.username{
            //cell.followingBtn.alpha = 0
            cell.followingBtn.isHidden = true
        }
    
        return cell
    }
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! followersCell
        
        if cell.userNameLbl.text == PFUser.current()?.username{
            let home = self.storyboard?.instantiateViewController(withIdentifier: "homeVC") as! homeVC
            self.navigationController?.pushViewController(home, animated: true)
        }else{
            guestname.append(cell.userNameLbl.text!)
            let guest = self.storyboard?.instantiateViewController(withIdentifier: "guestVC") as! guestVC
            self.navigationController?.pushViewController(guest, animated: true)
        }
        
    }

}
