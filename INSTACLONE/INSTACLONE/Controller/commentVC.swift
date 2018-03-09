//
//  commentVC.swift
//  INSTACLONE
//
//  Created by Vikky Chaudhary on 13/02/18.
//  Copyright © 2018 Vikky Chaudhary. All rights reserved.
//

import UIKit


var commentuuid = [String]()
var commentowner = [String]()

class commentVC: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var commentTxt: UITextView!
    @IBOutlet weak var sendBtn: UIButton!
    let refresher = UIRefreshControl()
    
    var tableviewHeight:CGFloat = 0
    var commetboxY:CGFloat = 0
    var commentboxHeight:CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        alignment()
    }

    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func alignment()
    {
        let width = self.view.frame.size.width
        let height = self.view.frame.size.height

        tableview.frame = CGRect(x: 0, y: 0, width: width, height: height/1.096 - (self.navigationController?.navigationBar.frame.size.height)! - 20)
        commentTxt.frame = CGRect(x: 10, y: tableview.frame.size.height+width/32, width: width/1.306, height: 33)
        sendBtn.frame = CGRect(x: commentTxt.frame.origin.x + commentTxt.frame.size.width + width/32, y:commentTxt.frame.origin.y, width:width - (commentTxt.frame.origin.x + commentTxt.frame.size.width + (width/32) * 2 ), height: commentTxt.frame.size.height)
        
        //assign reseting values
        
        tableviewHeight = tableview.frame.size.height
        commetboxY = commentTxt.frame.origin.y
        commentboxHeight = commentTxt.frame.size.height
    }
    

}
