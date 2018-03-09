//
//  signInVC.swift
//  INSTACLONE
//
//  Created by Vikky Chaudhary on 01/02/18.
//  Copyright © 2018 Vikky Chaudhary. All rights reserved.
//

import UIKit
import Parse

class signInVC: UIViewController {
 // inherit FBSDKLoginButtonDelegate
//    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
//     print("logout")
//        fetchprofile()
//    }
//
//    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
//        print("logout")
//    }
    

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var signUp_Here: UIButton!
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
   
//    let facebookBtn:FBSDKLoginButton = {
//        let loginbtn = FBSDKLoginButton()
//        loginbtn.readPermissions = ["email"]
//        return loginbtn
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.addSubview(facebookBtn)
//        let width = facebookBtn.frame.size.width
//        facebookBtn.frame.origin.x = self.view.frame.width/2 - width/2
//        facebookBtn.frame.origin.y = signUp_Here.frame.origin.y + 60
//        if let token = FBSDKAccessToken.current(){
//            fetchprofile()
//        }
    }
    
//    func fetchprofile(){
//        print("fetch profile")
//        let parameters = ["fields":"email,first_name,last_name,picture.type(large)"]
//        FBSDKGraphRequest(graphPath: "me", parameters: parameters).start { (connection, result, error) in
//            if error != nil{
//                print(error?.localizedDescription)
//            }
//            guard let results = result as? NSDictionary,
//            let email = results["email"] as?String
//            else{
//                return
//            }
//            print(email)
//        }
//    }
    

    @IBAction func signInBtn_click(_ sender: Any) {
        self.view.endEditing(true)
        
        if usernameTxt.text!.isEmpty || passwordTxt.text!.isEmpty{
            let alert = UIAlertController(title: "Login error", message: "Please filled all the details", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        }
        
        //Mark: login to tabbar
            PFUser.logInWithUsername(inBackground: usernameTxt.text!, password: passwordTxt.text!) { (user, error) in
            if error == nil{
                UserDefaults.standard.set(self.usernameTxt.text!, forKey: "username")
                UserDefaults.standard.synchronize()
                let appdelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
                appdelegate.login()
                print("signin clicked")
            }
            else{
                let alert = UIAlertController(title: "Login error", message: error.debugDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                }
        }
    }
}












