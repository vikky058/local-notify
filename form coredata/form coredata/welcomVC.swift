//
//  welcomVC.swift
//  form coredata
//
//  Created by Vikky Chaudhary on 19/02/18.
//  Copyright © 2018 Vikky Chaudhary. All rights reserved.
//

import UIKit
import CoreData

class welcomVC: UIViewController {

    @IBOutlet weak var fullname: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var logout: UIButton!
    @IBOutlet weak var imagee: UIImageView!
    
    var managedobj:NSManagedObjectContext?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    let appdel = UIApplication.shared.delegate as! AppDelegate
        managedobj = appdel.persistentContainer.viewContext
        let request:NSFetchRequest<Form> = Form.fetchRequest()
        do{
            let detail = try managedobj?.fetch(request)
            for it in detail!{
                fullname.text = it.name!
                email.text = it.email!
                let imgdata = it.ava
                imagee.image = UIImage(data: imgdata! as Data)
            }
        } catch {
            print("ok")
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
    @IBAction func logout_click(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "email")
    }
}
