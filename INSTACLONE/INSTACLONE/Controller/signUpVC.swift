//
//  signUpVC.swift
//  INSTACLONE
//
//  Created by Vikky Chaudhary on 01/02/18.
//  Copyright © 2018 Vikky Chaudhary. All rights reserved.
//

import UIKit
import Parse

class signUpVC: UIViewController,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var resetPassword: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var avaImg: UIImageView!
    @IBOutlet weak var fullnameTxt: UITextField!
    @IBOutlet weak var bioTxt: UITextField!
    @IBOutlet weak var webTxt: UITextField!
    
    @IBOutlet weak var signupBtn: UIButton!
    @IBOutlet weak var alreadyUserBtn: UIButton!
    @IBOutlet weak var scrolView: UIScrollView!
   
     var scrollViewHeight : CGFloat = 0
     var keyboard = CGRect()
  
    override func viewDidLoad() {
        super.viewDidLoad()
       
    //Mark: scroll view dize define
        scrolView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        scrolView.contentSize.height = self.view.frame.height
        scrollViewHeight = scrolView.frame.size.height
        
        NotificationCenter.default.addObserver(self, selector: #selector(signUpVC.showKeyboard(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(signUpVC.hideKeybard(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    
    //Mark: tap anywhere to hide the keyboard
        let hideTap = UITapGestureRecognizer(target: self, action: #selector(signUpVC.hideKeyboardTap(_:)))
        hideTap.numberOfTapsRequired = 1
        self.view.isUserInteractionEnabled = true
        self.view.addGestureRecognizer(hideTap)
        
    //Mark: Image Tap
        let avaTap = UITapGestureRecognizer(target: self, action: #selector(signUpVC.loadImg(_:)))
        avaTap.numberOfTapsRequired = 1
        avaImg.isUserInteractionEnabled = true
        avaImg.addGestureRecognizer(avaTap)
        
    // Mark: Round profile Image
        avaImg.layer.cornerRadius = avaImg.frame.size.width/2
        avaImg.clipsToBounds = true
        
    //Mark: Alignment
        avaImg.frame = CGRect(x: self.view.frame.size.width/2 - 40, y: scrolView.frame.origin.y + 40, width: 80, height: 80)
        usernameTxt.frame=CGRect(x: 10, y: avaImg.frame.origin.y + 130, width: self.view.frame.size.width - 20, height: 30)
        passwordTxt.frame = CGRect(x: 10, y: usernameTxt.frame.origin.y + 40, width: self.view.frame.size.width - 20, height: 30)
        resetPassword.frame = CGRect(x: 10, y: passwordTxt.frame.origin.y + 40, width: self.view.frame.size.width - 20, height: 30)
        emailTxt.frame = CGRect(x: 10, y: resetPassword.frame.origin.y + 40, width: self.view.frame.size.width - 20, height: 30)
        fullnameTxt.frame = CGRect(x: 10, y: emailTxt.frame.origin.y + 70, width: self.view.frame.size.width - 20, height: 30)
        bioTxt.frame = CGRect(x: 10, y: fullnameTxt.frame.origin.y + 40, width: self.view.frame.size.width - 20, height: 30)
        webTxt.frame = CGRect(x: 10, y: bioTxt.frame.origin.y + 40, width: self.view.frame.size.width - 20, height: 30)
        signupBtn.frame = CGRect(x: self.view.frame.size.width/2 - 80, y: webTxt.frame.origin.y + 50, width: 160, height: 45)
        alreadyUserBtn.frame = CGRect(x: self.view.frame.size.width/2 - 85, y: signupBtn.frame.origin.y + 55, width: 170, height: 45)
        
    }
  
    //Mark: upload the Image
    
    @objc func loadImg(_ recognizer:UIGestureRecognizer){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        avaImg.image = info[UIImagePickerControllerEditedImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    
    //Mark: hide keyboard
    @objc func hideKeyboardTap(_ recoginizer:UITapGestureRecognizer){
        UIView.animate(withDuration: 0.5) {
            self.view.endEditing(true)
        }
    }
    
    //Mark: show Keyboard
    @objc func showKeyboard(_ notification:Notification) {
    
        keyboard = ((notification.userInfo?[UIKeyboardFrameEndUserInfoKey]! as AnyObject).cgRectValue)!
    
        UIView.animate(withDuration: 0.4, animations: { () -> Void in
            self.scrolView.frame.size.height = self.scrollViewHeight - self.keyboard.height
        })
    }
    
    //Mark: Hide keyboard
    @objc func hideKeybard(_ notification:Notification) {
        
        // move down UI
        UIView.animate(withDuration: 0.4, animations: { () -> Void in
            self.scrolView.frame.size.height = self.view.frame.height
        })
    }
    
    @IBAction func signUpBtn_click(_ sender: Any) {
        print("signup pressed")
        if (usernameTxt.text!.isEmpty || passwordTxt.text!.isEmpty || resetPassword.text!.isEmpty || emailTxt.text!.isEmpty || fullnameTxt.text!.isEmpty || bioTxt.text!.isEmpty || webTxt.text!.isEmpty){
            
            let alert = UIAlertController(title: "Please", message: "fill all the required details", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        if passwordTxt.text != resetPassword.text {
            let alert = UIAlertController(title: "Password", message: "Password not matched!", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        let user = PFUser()
        
        user.email = emailTxt.text?.lowercased()
        user.username = usernameTxt.text
        user.password = passwordTxt.text
        user["fullname"] = fullnameTxt.text
        user["bio"] = bioTxt.text
        user["web"] = webTxt.text
        
        user["tel"] = ""
        user["gender"] = ""
        
        let avaData = UIImageJPEGRepresentation(avaImg.image!, 0.5)
        let avaFile = PFFile(name: "ava.jpg", data: avaData!)
        user["ava"] = avaFile
        user.signUpInBackground { (success, error) in
            if success{
                print("success")
                
    //Mark: remember the username
                UserDefaults.standard.set(user.username, forKey: "username")
                UserDefaults.standard.synchronize()
    
    //Mark: after signup move next with tabbar
                let appdelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
                appdelegate.login()
                
            }else
            {
                print(error)
                print("error")
            }
        }
        
    }
  
    @IBAction func AlreadyUser_click(_ sender: Any) {
        UIView.animate(withDuration: 0.5) {
            self.dismiss(animated: true, completion: nil)
        }
    }
}























