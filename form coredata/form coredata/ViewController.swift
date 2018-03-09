//
//  ViewController.swift
//  form coredata
//
//  Created by Vikky Chaudhary on 19/02/18.
//  Copyright © 2018 Vikky Chaudhary. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
   
    @IBOutlet weak var fullname: UITextField!
    @IBOutlet weak var avaImg: UIImageView!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var submit: UIButton!
    
    var manageobjectcontext:NSManagedObjectContext?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appdelegate = UIApplication.shared.delegate as? AppDelegate
        manageobjectcontext = appdelegate?.persistentContainer.viewContext
        
        submit.layer.cornerRadius = 15
        avaImg.layer.cornerRadius = avaImg.frame.width/2
        avaImg.clipsToBounds = true
        avaImg.layer.borderColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
        avaImg.layer.borderWidth = 5
        
        let imgtap = UITapGestureRecognizer(target: self, action: #selector(ViewController.image(recog:)))
        imgtap.numberOfTapsRequired = 1
        avaImg.isUserInteractionEnabled = true
        avaImg.addGestureRecognizer(imgtap)
    }

    @objc func image(recog:UIGestureRecognizer){
        let imagepic = UIImagePickerController()
        imagepic.delegate = self
        imagepic.sourceType = .photoLibrary
        imagepic.allowsEditing = true
        self.present(imagepic, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        avaImg.image = info[UIImagePickerControllerEditedImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func submit_click(_ sender: Any) {
        let detail = Form(context: manageobjectcontext!)
        detail.email = email.text
        detail.name = fullname.text
        let img = avaImg.image
        let imagdata:NSData = UIImageJPEGRepresentation(img!, 0.5)! as NSData
        detail.ava = imagdata
        
        
        do{
            try self.manageobjectcontext?.save()
            UserDefaults.standard.set(email.text, forKey: "email")
            UserDefaults.standard.synchronize()
            print("data saved")
        }catch{
            print("error")
        }
        
        let app = UIApplication.shared.delegate as? AppDelegate
        app?.login()
    }
    
    
}

