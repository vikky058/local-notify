//
//  homeVC.swift
//  INSTACLONE
//
//  Created by Vikky Chaudhary on 04/02/18.
//  Copyright © 2018 Vikky Chaudhary. All rights reserved.
//

import UIKit
import Parse

class homeVC: UICollectionViewController {

    //Mark: refresher control
    var refresher:UIRefreshControl!
    
    // pic array
    var pic = [PFFile]()
    
    //uuid array
    var uuid = [String]()
    
    //page number
    var page = 12
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView?.alwaysBounceVertical = true
        navigationItem.title = PFUser.current()?.username?.uppercased()
        refresher = UIRefreshControl()
        refresher.addTarget(self, action: #selector(homeVC.refresh), for:UIControlEvents.valueChanged)
        collectionView?.addSubview(refresher)
        NotificationCenter.default.addObserver(self, selector: #selector(homeVC.refresh), name: NSNotification.Name(rawValue: "editComplete"), object: nil)
        NotificationCenter.default.addObserver(self, selector:#selector(homeVC.upload), name: NSNotification.Name(rawValue: "uploded"), object: nil)
        loadPosts()
        refresh()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        refresh()
    }
    
   @objc func refresh(){
        collectionView?.reloadData()
        refresher.endRefreshing()
    }
    
    
    @objc func upload(notification:NSNotification){
        loadPosts()
    }
    
    func loadPosts()
    {
        let query = PFQuery(className: "posts")
        query.whereKey("username", equalTo: PFUser.current()?.username)
        query.limit = page
        query.findObjectsInBackground { (objects, error) in
            if error == nil{
                
                self.pic.removeAll(keepingCapacity: false)
                self.uuid.removeAll(keepingCapacity: false)
    //Mark: find object related to query
                for object in objects! {
                    self.pic.append(object.value(forKey: "pic") as! PFFile)
                    self.uuid.append(object.value(forKey: "uuid") as! String)
                }
                self.collectionView?.reloadData()
            }else{
                print("error to find object")
            }
        }
    }
   
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y >= scrollView.contentSize.height - view.frame.size.height{
            self.loadmore()
        }
    }
    
    func loadmore(){
        if page <= pic.count{
            page += 12
        }
        let query = PFQuery(className: "posts")
        query.whereKey("username", equalTo: PFUser.current()?.username)
        query.limit = page
        query.findObjectsInBackground { (objects, error) in
            if error == nil{
                
                self.pic.removeAll(keepingCapacity: false)
                self.uuid.removeAll(keepingCapacity: false)
                //Mark: find object related to query
                for object in objects! {
                    self.pic.append(object.value(forKey: "pic") as! PFFile)
                    self.uuid.append(object.value(forKey: "uuid") as! String)
                }
                self.collectionView?.reloadData()
            }else{
                print("error to find object")
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pic.count
    }

//Mark: cell configure
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! homePictures
        pic[indexPath.row].getDataInBackground { (data, error) in
            if error == nil{
                cell.picImage.image = UIImage(data: data!)
            }else{
                print(error?.localizedDescription)
            }
        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "Header", for: indexPath) as! homeHeaderView
        header.fullnameLbl.text = PFUser.current()?.object(forKey: "fullname") as? String
        header.bioLbl.text = PFUser.current()?.object(forKey: "bio") as? String
        header.bioLbl.sizeToFit()
        header.webTxt.text = PFUser.current()?.object(forKey: "web") as? String
        header.webTxt.sizeToFit()
        
        let avaQuery = PFUser.current()?.object(forKey: "ava") as! PFFile
        avaQuery.getDataInBackground { (data, error) -> Void in
        header.avaImg.image = UIImage(data: data!)
        }
            //Mark: count post
        let post = PFQuery(className: "posts")
        post.whereKey("username", equalTo: PFUser.current()?.username)
            post.countObjectsInBackground(block: { (count, error) in
                if error == nil{
                    header.postCount.text = "\(count)"
                }
            })
        
            // Mark: count followers
            
            let followers = PFQuery(className: "follow")
            followers.whereKey("following", equalTo: PFUser.current()?.username)
            followers.countObjectsInBackground(block: { (count, error) in
                if error == nil{
                    header.followersCount.text = "\(count)"
                }
            })
            
            //Mark: count following
            let following = PFQuery(className: "follow")
            following.whereKey("follower", equalTo: PFUser.current()?.username)
            following.countObjectsInBackground(block: { (count, error) in
                if error == nil{
                    header.followingCount.text = "\(count)"
                }
            })
        
        //Mark: post tap gesture
        let postTap = UITapGestureRecognizer(target: self, action: #selector(homeVC.postsTap))
        postTap.numberOfTapsRequired = 1
        header.posts.isUserInteractionEnabled = true
        header.posts.addGestureRecognizer(postTap)
        
        let followerTap = UITapGestureRecognizer(target: self, action: #selector(homeVC.followerTap))
        followerTap.numberOfTapsRequired = 1
        header.followers.isUserInteractionEnabled = true
        header.followers.addGestureRecognizer(followerTap)
        
        let followingTap = UITapGestureRecognizer(target: self, action:#selector(homeVC.followingTap))
        followingTap.numberOfTapsRequired = 1
        header.following.isUserInteractionEnabled = true
        header.following.addGestureRecognizer(followingTap)
        
        return header
    }

    @objc func postsTap(){
        if !pic.isEmpty{
            let index = IndexPath(item: 0, section: 0)
            self.collectionView?.scrollToItem(at: index, at: UICollectionViewScrollPosition.top, animated: true)
        }
    }
    
    @objc func followerTap()
    {
        user = (PFUser.current()?.username)!
        showTap = "follower"
        
        let followers = self.storyboard?.instantiateViewController(withIdentifier: "followersVC") as! followersVC
        self.navigationController?.pushViewController(followers, animated: true)
    }
    
    @objc func followingTap()
    {
        user = (PFUser.current()?.username)!
        showTap = "following"
        
        let following = self.storyboard?.instantiateViewController(withIdentifier: "followersVC") as! followersVC
         self.navigationController?.pushViewController(following, animated: true)
    }
    
    
    @IBAction func logout_clicked(_ sender: Any) {
        
        PFUser.logOutInBackground { (error) in
            if error == nil{
                UserDefaults.standard.removeObject(forKey: "username")
                UserDefaults.standard.synchronize()
                let loginBoard = self.storyboard?.instantiateViewController(withIdentifier: "signInVC") as! signInVC
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.window?.rootViewController = loginBoard
            }
        }
    }
//
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        postuuid.append(uuid[indexPath.row])
        let post = self.storyboard?.instantiateViewController(withIdentifier: "postVC") as! postVC
        self.navigationController?.pushViewController(post, animated: true)
    }
    
    
}













