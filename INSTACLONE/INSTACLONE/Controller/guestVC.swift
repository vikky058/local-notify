//
//  guestVC.swift
//  INSTACLONE
//
//  Created by Vikky Chaudhary on 07/02/18.
//  Copyright © 2018 Vikky Chaudhary. All rights reserved.
//

import UIKit
import Parse

var guestname = [String]()

class guestVC: UICollectionViewController {

    var refresh:UIRefreshControl!
    var  page = 12
    
    var uuid = [String]()
    var picArray = [PFFile]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.alwaysBounceVertical = true
        navigationItem.title = guestname.last?.uppercased()
        
        //navigation back button
        navigationItem.hidesBackButton = true
        let backBtn = UIBarButtonItem(title: "back", style:  .plain, target: self, action: #selector(guestVC.back(sender:)))
        navigationItem.leftBarButtonItem = backBtn
        
        //swipe guesture
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(guestVC.back(sender:)))
        swipe.direction = .right
        self.view.addGestureRecognizer(swipe)
        
        // refresher
        refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(guestVC.refresher), for: .valueChanged)
        collectionView?.addSubview(refresh)
        
    }
    
   @objc func back(sender:UIBarButtonItem){
        self.navigationController?.popViewController(animated: true)
    if !guestname.isEmpty{
          guestname.removeLast()
        }
    }
    
    @objc func refresher(){
        collectionView?.reloadData()
        refresh.endRefreshing()
    }
  
    func loadPosts(){
        let query = PFQuery(className: "posts")
        query.whereKey("username", equalTo: guestname.last)
        query.limit = 10
        query.findObjectsInBackground { (objects, error) in
            if error == nil{
                
                for object in objects!{
                    self.picArray.append(object["pic"] as! PFFile)
                    self.uuid.append(object["uuid"] as! String)
                }
                self.collectionView?.reloadData()
            }else{
                print(error?.localizedDescription)
            }
        }
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y >= scrollView.contentSize.height - view.frame.size.height{
            self.loadmore()
        }
    }
    
    //pagination function
    func loadmore(){
        if page <= picArray.count{
            page += 12
        }
        let query = PFQuery(className: "posts")
        query.whereKey("username", equalTo: guestname.last)
        query.limit = page
        query.findObjectsInBackground { (objects, error) in
            if error == nil{
                
                self.picArray.removeAll(keepingCapacity: false)
                self.uuid.removeAll(keepingCapacity: false)
                //Mark: find object related to query
                for object in objects! {
                    self.picArray.append(object.value(forKey: "pic") as! PFFile)
                    self.uuid.append(object.value(forKey: "uuid") as! String)
                }
                
                self.collectionView?.reloadData()
            }else{
                print("error to find object")
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return picArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! homePictures
        picArray[indexPath.row].getDataInBackground { (data, error) in
            cell.picImage.image = UIImage(data: data!)
        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "Header", for: indexPath) as! homeHeaderView
        
        let query1 = PFUser.query()
        query1?.whereKey("username", equalTo: guestname.last)
        query1?.findObjectsInBackground(block: { (objects, error) in
            if error == nil{
                for object in objects!{
                    header.bioLbl.text = object["bio"] as! String
                    header.fullnameLbl.text = object["fullname"] as! String
                    header.webTxt.text = object["web"] as! String
                    let avafile:PFFile = object["ava"] as! PFFile
                    avafile.getDataInBackground(block: { (data, error) in
                        header.avaImg.image = UIImage(data: data!)
                    })
                }
            } else{
                print(error?.localizedDescription)
            }
        })
        
        // check current user follow or not
        let query3 = PFQuery(className: "follow")
        query3.whereKey("follower", equalTo: PFUser.current()?.username)
        query3.whereKey("following", equalTo: guestname.last)
        query3.countObjectsInBackground { (count, error) in
            if count == 1{
                header.editProfileBtn.setTitle("FOLLOWING", for: .normal)
                header.editProfileBtn.layer.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            }else{
                header.editProfileBtn.setTitle("FOLLOW", for: .normal)
                header.editProfileBtn.layer.backgroundColor = #colorLiteral(red: 0.7159407907, green: 0.7232709391, blue: 0.7144392357, alpha: 1)
            }
        }
        
        //check post
        
        let query4 = PFQuery(className: "posts")
        query4.whereKey("username", equalTo: guestname.last)
        query4.countObjectsInBackground { (count, error) in
            if error == nil{
                header.postCount.text = "\(count)"
            }
        }
        
        // check follower
        let query5 = PFQuery(className: "follow")
        query5.whereKey("following", equalTo: guestname.last)
        query5.countObjectsInBackground { (count, error) in
            if error == nil{
                header.followersCount.text = "\(count)"
            }
        }
        
        //count following
        let query6 = PFQuery(className: "follow")
        query6.whereKey("follower", equalTo: guestname.last)
        query6.countObjectsInBackground { (count, error) in
            if error == nil{
                header.followingCount.text = "\(count)"
            }
        }
        
        //Add Tap guesture
        let postTap = UITapGestureRecognizer(target: self, action: #selector(guestVC.postTap))
        postTap.numberOfTapsRequired = 1
        header.posts.isUserInteractionEnabled = true
        header.posts.addGestureRecognizer(postTap)
        
        let followerTap = UITapGestureRecognizer(target: self, action:  #selector(guestVC.followerTap))
        followerTap.numberOfTapsRequired = 1
        header.followers.isUserInteractionEnabled = true
        header.followers.addGestureRecognizer(followerTap)
        
        let followingTap = UITapGestureRecognizer(target: self, action:  #selector (guestVC.followingtap))
        followingTap.numberOfTapsRequired = 1
        header.following.isUserInteractionEnabled = true
        header.following.addGestureRecognizer(followingTap)
        
        return header
    }
    
    
    @objc func postTap()
    {
        let index = IndexPath(item: 0, section: 0)
        collectionView?.scrollToItem(at: index, at: .top, animated: true)
    }
    
    @objc func followerTap(){
        user = "follower"
        let follower = self.storyboard?.instantiateViewController(withIdentifier: "followersVC") as! followersVC
        self.navigationController?.pushViewController(follower, animated: true)
    }
    
    @objc func followingtap(){
        user = "following"
        let following = self.storyboard?.instantiateViewController(withIdentifier: "followersVC") as! followersVC
        self.navigationController?.pushViewController(following, animated: true)
        
    }
    
}





















