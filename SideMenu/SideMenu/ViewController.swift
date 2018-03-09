//
//  ViewController.swift
//  SideMenu
//
//  Created by Vikky Chaudhary on 29/01/18.
//  Copyright © 2018 Vikky Chaudhary. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var ViewConstraints: NSLayoutConstraint!
    @IBOutlet weak var sideView: UIView!
    @IBOutlet weak var blurView: UIVisualEffectView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        blurView.layer.cornerRadius = 35
        blurView.layer.shadowColor = #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1)
        blurView.layer.shadowOpacity = 1
        blurView.layer.shadowOffset = CGSize(width: 5, height: 0)
        ViewConstraints.constant = -229
    }

    @IBAction func panPerformed(_ sender: UIPanGestureRecognizer) {
        
        if sender.state == .began || sender.state == .changed{
            let translation = sender.translation(in: self.view).x
            if translation>0 {                      //swipe right
                
                if ViewConstraints.constant < 20{
                    UIView.animate(withDuration: 0.5, delay: 0.0, options: [.curveEaseIn], animations: {
                        self.ViewConstraints.constant += translation
                        self.view.layoutIfNeeded()
                    }, completion: nil)
                }
                
                
                
            }else{
                if ViewConstraints.constant > -229{
                    UIView.animate(withDuration: 0.5, delay: 0.0, options: [.curveEaseIn], animations: {
                        self.ViewConstraints.constant += translation
                        self.view.layoutIfNeeded()
                    }, completion: nil)
                }
            }
            
            
        }else if sender.state == .ended{
            if ViewConstraints.constant < -100{
                UIView.animate(withDuration: 0.5, delay: 0.0, options: [.curveEaseIn], animations: {
                    self.ViewConstraints.constant = -229
                    self.view.layoutIfNeeded()
                }, completion: nil)
            }
            else{
                UIView.animate(withDuration: 0.5, delay: 0.0, options: [.curveEaseIn], animations: {
                    self.ViewConstraints.constant = 0
                    self.view.layoutIfNeeded()
                }, completion: nil)
                
            }
        }
        
    }

}


















