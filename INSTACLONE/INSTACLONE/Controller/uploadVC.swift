//
//  uploadVC.swift
//  INSTACLONE
//
//  Created by Vikky Chaudhary on 08/02/18.
//  Copyright © 2018 Vikky Chaudhary. All rights reserved.
//

import UIKit
import Parse

class uploadVC: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var postTitle: UITextView!
    @IBOutlet weak var avaImage: UIImageView!
    @IBOutlet weak var publishBtn: UIButton!
    @IBOutlet weak var remove_click: UIButton!
    
    
    var unzoomed = CGRect()
   
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
       
        avaImage.layer.cornerRadius = avaImage.frame.size.width/2
        avaImage.clipsToBounds = true
        
        publishBtn.isEnabled = false
        publishBtn.backgroundColor = #colorLiteral(red: 0.7159407907, green: 0.7232709391, blue: 0.7144392357, alpha: 1)
        
        postTitle.layer.cornerRadius = 5
        postTitle.layer.borderColor = #colorLiteral(red: 0.766900867, green: 0.1818033259, blue: 1, alpha: 1)
        postTitle.layer.borderWidth = 2
        
        //hide remove btn
        remove_click.alpha = 0
        
        //reset image
        avaImage.image = UIImage(named: "back.jpg")
        
        //hide keyboard
        let hideTap = UITapGestureRecognizer(target: self, action: #selector(uploadVC.hidekeyBoard))
        hideTap.numberOfTapsRequired = 1
        self.view.isUserInteractionEnabled = true
        self.view.addGestureRecognizer(hideTap)

        //tap image
        let avaTap = UITapGestureRecognizer(target: self, action: #selector(uploadVC.selectImage(recognizer:)))
        avaTap.numberOfTapsRequired = 1
        avaImage.isUserInteractionEnabled = true
        avaImage.addGestureRecognizer(avaTap)
        
        //alignment
        alignment()
        unzoomed = avaImage.frame
    }
    
    @objc func hidekeyBoard(){
        self.view.endEditing(true)
    }

    @objc func selectImage(recognizer:UIGestureRecognizer){
    let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        avaImage.image = info[UIImagePickerControllerEditedImage] as! UIImage
        self.dismiss(animated: true, completion: nil)
        
    //enable btn
        remove_click.alpha = 1
        publishBtn.isEnabled = true
        publishBtn.backgroundColor = #colorLiteral(red: 0.766900867, green: 0.1818033259, blue: 1, alpha: 1)
        
   //zoom in zoom out gesture
        let zoomTap = UITapGestureRecognizer(target: self, action: #selector(uploadVC.zoomImg))
        zoomTap.numberOfTapsRequired = 1
        avaImage.isUserInteractionEnabled = true
        avaImage.addGestureRecognizer(zoomTap)
    }
    
    @objc func zoomImg(){
       // let unzoomed = CGRect(x: 82, y: 95, width: (self.view.frame.size.width/2) - 105, height: (self.view.frame.size.width/2) - 105)
    
        let zoomed = CGRect(x: 0, y: self.view.center.y - self.view.center.x - (self.tabBarController?.tabBar.frame.size.height)!, width: self.view.frame.size.width, height: self.view.frame.size.width)

        if avaImage.frame == unzoomed{
            UIView.animate(withDuration: 0.5, animations: {
                self.avaImage.frame = zoomed
                self.avaImage.layer.cornerRadius = 0
                self.view.backgroundColor = #colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1)
                self.publishBtn.alpha = 0
                self.postTitle.alpha = 0
                self.remove_click.alpha = 0
                
            })
        } else{
            UIView.animate(withDuration: 0.5, animations: {
                self.avaImage.frame = self.unzoomed
                self.avaImage.layer.cornerRadius = self.avaImage.frame.size.width/2
                self.view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                self.publishBtn.alpha = 1
                self.postTitle.alpha = 1
                self.remove_click.alpha = 1
            })
        }
    }
    
    @IBAction func publishBtn_click(_ sender: Any) {
        self.view.endEditing(true)
        let object = PFObject(className: "posts")
        object["username"] = PFUser.current()?.username
        object["ava"] = PFUser.current()?.object(forKey: "ava") as! PFFile
        let uuid = NSUUID().uuidString
        object["uuid"] = "\(PFUser.current()!.username)\(uuid)"
        if postTitle.text.isEmpty{
            object["title"] = ""
        }else
        {
            object["title"] = postTitle.text
        }
        
        let avaimg = UIImageJPEGRepresentation(avaImage.image!, 0.5)
        let avafile = PFFile(name: "ava.jpg", data: avaimg!)
        object["pic"] = avafile
        object.saveInBackground { (success, error) in
            if success{
                 print("success")
                self.dismiss(animated: true, completion: nil)
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "uploded"), object: nil)
                self.tabBarController?.selectedIndex = 0
                self.viewDidLoad()
                self.postTitle.text = ""
            }else
            {
                print(error?.localizedDescription)
            }
        }
    }

    @IBAction func removeBtn_click(_ sender: Any) {
        viewDidLoad()
    }
    
    func alignment()
    {
    let width = self.view.frame.size.width
    let height = self.view.frame.size.height

    avaImage.frame = CGRect(x: 50, y: 15, width: width - 100, height: width - 100)
    remove_click.frame = CGRect(x: avaImage.frame.width/2, y: avaImage.frame.origin.y + avaImage.frame.size.height + 5, width: width/4, height: 20)
    postTitle.frame = CGRect(x: 10, y: remove_click.frame.origin.y + 30, width: width-20, height: 100)
    //publishBtn.frame = CGRect(x: 0, y: height/1.4, width: width, height:width/8)
    }
}


















