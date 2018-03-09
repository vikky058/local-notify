//
//  resetPasswordVC.swift
//  INSTACLONE
//
//  Created by Vikky Chaudhary on 01/02/18.
//  Copyright © 2018 Vikky Chaudhary. All rights reserved.
//

import UIKit
import Parse

class resetPasswordVC: UIViewController {

    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var resetBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
   
    @IBAction func resetBtn_click(_ sender: Any) {
    self.view.endEditing(true)
        if emailTxt.text!.isEmpty{
            let alert = UIAlertController(title: "Reset!", message: "Please fill email id.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        PFUser.requestPasswordResetForEmail(inBackground: emailTxt.text!) { (success, error) in
            if success {
                let alert = UIAlertController(title: "Email for reseting password", message: "has been sent to your email", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (UIAlertAction) in
                    self.dismiss(animated: true, completion: nil)
                }))
                self.present(alert, animated: true, completion: nil)
                
            }else{
                print(error?.localizedDescription)
            }
        }
    }

    @IBAction func cancelBtn_click(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}
