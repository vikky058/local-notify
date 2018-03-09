//
//  editVC.swift
//  INSTACLONE
//
//  Created by Vikky Chaudhary on 08/02/18.
//  Copyright © 2018 Vikky Chaudhary. All rights reserved.
//

import UIKit
import Parse

class editVC: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
   
    @IBOutlet weak var fullnameTxt: UITextField!
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var webTxt: UITextField!
    @IBOutlet weak var bioTxt: UITextView!
    
    @IBOutlet weak var avaimg: UIImageView!
    @IBOutlet weak var gmail: UITextField!
    @IBOutlet weak var telPhone: UITextField!
    @IBOutlet weak var gender: UITextField!
    
    var genderPicker:UIPickerView!
    var pickerArray = ["Male","Femele"]
    
    @IBOutlet weak var scrollView: UIScrollView!
   
    //Keyboard
    var keyboard = CGRect()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        avaimg.layer.cornerRadius = avaimg.frame.size.width/2
        avaimg.clipsToBounds  = true
        genderPicker = UIPickerView()
        genderPicker.delegate = self
        genderPicker.dataSource = self
        genderPicker.backgroundColor = UIColor.groupTableViewBackground
        genderPicker.showsSelectionIndicator = true
        gender.inputView = genderPicker
        
        NotificationCenter.default.addObserver(self, selector: #selector(editVC.keyboardShow(notification:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(editVC.keyboardHide(notification:)), name: .UIKeyboardWillHide, object: nil)
        
        //tap to hide keyboard
        let tap = UITapGestureRecognizer(target: self, action: #selector(editVC.hidekeyboard))
        tap.numberOfTapsRequired = 1
        self.view.isUserInteractionEnabled = true
        self.view.addGestureRecognizer(tap)
        
        //tap to edit image
        let avaTap = UITapGestureRecognizer(target: self, action: #selector(editVC.loadImage(recognizer:)))
        avaTap.numberOfTapsRequired = 1
        avaimg.isUserInteractionEnabled = true
        avaimg.addGestureRecognizer(avaTap)
        
        information()
    }
    
    @objc func keyboardShow(notification:NSNotification){
        
      keyboard = ((notification.userInfo?[UIKeyboardFrameEndUserInfoKey]! as AnyObject).cgRectValue)!
        UIView.animate(withDuration: 0.5) {
            self.scrollView.contentSize.height = self.view.frame.size.height + self.keyboard.height/2
        }
    }
    
    @objc func keyboardHide(notification:NSNotification){
        UIView.animate(withDuration: 0.05) {
            self.scrollView.contentSize.height = 0
        }
    }
    
    @objc func hidekeyboard(){
        self.view.endEditing(true)
    }
    
    @IBAction func cancel_clicked(_ sender: Any) {
    self.view.endEditing(true)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func save_clicked(_ sender: Any) {
        if !validEmail(email: gmail.text!){
            alert(error: "Invalid email", message: "Please provide vaild email")
            return
        }
        if !validWeb(web: webTxt.text!){
            alert(error: "Invalid web", message: "Please provide valid web")
            return
        }
        
        let user = PFUser.current()!
        user.email = gmail.text
        user["bio"] = bioTxt.text as! String
        user["web"] = webTxt.text?.lowercased()
        if (telPhone.text?.isEmpty)! {
            user["tel"] = ""
        }else{
            user["tel"] = telPhone.text
        }
        
        if (gender.text?.isEmpty)!{
            user["gender"] = ""
        }else{
            user["gender"] = gender.text
        }
        
        let avaData = UIImageJPEGRepresentation(avaimg.image!, 0.5)
        let avafile = PFFile(name: "ava.jpg", data: avaData!)
        user["ava"] = avafile
        
        user.saveInBackground { (success, error) in
            if success{
                self.view.endEditing(true)
                print("saved")
                self.dismiss(animated: true, completion: nil)
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "editComplete"), object: nil)
                
            }else
            {
                print(error?.localizedDescription)
            }
        }
        
    }
    
    //Mark: load ava Image
    
    @objc func loadImage(recognizer:UITapGestureRecognizer)
    {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        avaimg.image = info[UIImagePickerControllerEditedImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    
    //Load data from server
    func information(){
        let ava = PFUser.current()?.object(forKey: "ava") as! PFFile
        ava.getDataInBackground { (data, error) in
            if error == nil{
                self.avaimg.image = UIImage(data: data!)
            }
        }
        usernameLbl.text = PFUser.current()?.username
        fullnameTxt.text = PFUser.current()?.object(forKey: "fullname") as? String
        bioTxt.text = PFUser.current()?.object(forKey: "bio") as? String
        webTxt.text = PFUser.current()?.object(forKey: "web") as? String
        gmail.text = PFUser.current()?.object(forKey: "email") as? String
    }

    func validEmail(email:String) ->Bool
    {
        let regex = "[A-Z0-9a-z._%+-]{4}+@[A-Za-z0-9.-]+\\.[A-Za-z]{2}"
        let range = email.range(of: regex, options: .regularExpression)
        let result = range != nil ? true : false
        return result
        
    }
    
    func validWeb(web:String) -> Bool{
        let regex = "www.[A-Z0-9a-z._%+-]+.[A-Za-z]{2}"
        let range = web.range(of: regex, options: .regularExpression)
        let result = range != nil ? true : false
        return result
    }
    func alert(error:String,message:String)
    {
        let alert = UIAlertController(title: error, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerArray[row]
    }
   
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        gender.text = pickerArray[row]
        self.view.endEditing(true)
    }
    
}






















