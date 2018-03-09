//
//  loginVC.swift
//  Uber_Firebase_clone
//
//  Created by Vikky Chaudhary on 08/03/18.
//  Copyright © 2018 Vikky Chaudhary. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class loginVC: UIViewController {
    
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passTxt: UITextField!
    @IBOutlet weak var segment: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.bindtokeyboard()
        let tap = UITapGestureRecognizer(target: self, action: #selector(handelScrenTap(sender:)))
        view.addGestureRecognizer(tap)
    }

    @objc func handelScrenTap(sender:UITapGestureRecognizer){
        self.view.endEditing(true)
    }
  
    @IBAction func cancel_clicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func auth_clicked(_ sender: Any) {
        print("abcd")
        print(Database.database().reference())
        if emailTxt.text != nil && passTxt.text != nil{
            if let email = emailTxt.text , let pass = passTxt.text{
                Auth.auth().signIn(withEmail: email, password: pass, completion: { (user, error) in
                    if error == nil{
                        if let user = user{
                            if self.segment.selectedSegmentIndex == 0{
                                let userdata = ["provider":user.providerID] as [String:Any]
                                DataService.instance.createFirebaseDBUser(uid: user.uid, userData: userdata, isdriver: false)
                            }else{
                                let userdata = ["provider":user.providerID, "userIsDriver":true, "isPickupModeEnabled":false , "driverIsOnTrip":false] as [String:Any]
                                DataService.instance.createFirebaseDBUser(uid: user.uid, userData: userdata, isdriver: true)
                            }
                        }
                        print("email user authentication with userbase")
                        self.dismiss(animated: true, completion: nil)
                    } else{
                        Auth.auth().createUser(withEmail: email, password: pass, completion: { (user, error) in
                            if error != nil
                            {
                                if let errorcode = AuthErrorCode(rawValue: error!._code){
                                    switch errorcode{
                                    
                                    case .invalidCustomToken:
                                    print("a")
                                    case .customTokenMismatch:
                                        print("b1")
                                    case .invalidCredential:
                                        print("b2")
                                    case .userDisabled:
                                        print("b3")
                                    case .operationNotAllowed:
                                        print("b33")
                                    case .emailAlreadyInUse:
                                        print("b4")
                                    case .invalidEmail:
                                        print("b44")
                                    case .wrongPassword:
                                        print("b5")
                                    case .tooManyRequests:
                                        print("b55")
                                    case .userNotFound:
                                        print("b555")
                                    case .accountExistsWithDifferentCredential:
                                        print("b5555")
                                    case .requiresRecentLogin:
                                        print("b6")
                                    case .providerAlreadyLinked:
                                        print("b66")
                                    case .noSuchProvider:
                                        print("b666")
                                    case .invalidUserToken:
                                        print("b6666")
                                    case .networkError:
                                        print("b7")
                                    case .userTokenExpired:
                                        print("b77")
                                    case .invalidAPIKey:
                                        print("b777")
                                    case .userMismatch:
                                        print("b7777")
                                    case .credentialAlreadyInUse:
                                        print("b8")
                                    case .weakPassword:
                                        print("b88")
                                    case .appNotAuthorized:
                                        print("b888")
                                    case .expiredActionCode:
                                        print("b8888")
                                    case .invalidActionCode:
                                        print("b9")
                                    case .invalidMessagePayload:
                                        print("b99")
                                    case .invalidSender:
                                        print("b999")
                                    case .invalidRecipientEmail:
                                        print("b9999")
                                    case .missingEmail:
                                        print("b0")
                                    case .missingIosBundleID:
                                        print("b00")
                                    case .missingAndroidPackageName:
                                        print("b000")
                                    case .unauthorizedDomain:
                                        print("b000")
                                    case .invalidContinueURI:
                                        print("b")
                                    case .missingContinueURI:
                                        print("b")
                                    case .missingPhoneNumber:
                                        print("b")
                                    case .invalidPhoneNumber:
                                        print("b")
                                    case .missingVerificationCode:
                                        print("b")
                                    case .invalidVerificationCode:
                                        print("b")
                                    case .missingVerificationID:
                                        print("b")
                                    case .invalidVerificationID:
                                        print("b")
                                    case .missingAppCredential:
                                        print("b")
                                    case .invalidAppCredential:
                                        print("b")
                                    case .sessionExpired:
                                        print("b")
                                    case .quotaExceeded:
                                        print("b")
                                    case .missingAppToken:
                                        print("b")
                                    case .notificationNotForwarded:
                                        print("b")
                                    case .appNotVerified:
                                        print("b")
                                    case .captchaCheckFailed:
                                        print("b")
                                    case .webContextAlreadyPresented:
                                        print("b")
                                    case .webContextCancelled:
                                        print("b")
                                    case .appVerificationUserInteractionFailure:
                                        print("b")
                                    case .invalidClientID:
                                        print("b")
                                    case .webNetworkRequestFailed:
                                        print("b")
                                    case .webInternalError:
                                        print("b")
                                    case .keychainError:
                                        print("b")
                                    case .internalError:
                                        print("b")
                                    
                                    }
                                }
                            }else{
                                if let user = user{
                                    if self.segment.selectedSegmentIndex == 0{
                                        let userdata = ["provider":user.providerID] as [String:Any]
                                        DataService.instance.createFirebaseDBUser(uid: user.uid, userData: userdata, isdriver: false)
                                    }
                                    else{
                                        let userdata = ["provider":user.providerID, "userIsDriver":true, "isPickupModeEnabled":false , "driverIsOnTrip":false] as [String:Any]
                                        DataService.instance.createFirebaseDBUser(uid: user.uid, userData: userdata, isdriver: true)
                                    }
                                }
                                print("Successfull created new user with firebase")
                                self.dismiss(animated: true, completion: nil)
                            }
                        })
                    }
                })
            }
        }
    }
    
}



















