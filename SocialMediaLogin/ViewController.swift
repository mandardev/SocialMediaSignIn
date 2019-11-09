//
//  ViewController.swift
//  SocialMediaLogin
//
//  Created by Mandar Choudhary on 09/11/19.
//  Copyright © 2019 Mandar Choudhary. All rights reserved.
//

import UIKit
import GoogleSignIn

class ViewController: UIViewController, GIDSignInDelegate {

    @IBOutlet weak var gmailSignInButton: UIButton!
    
    @IBOutlet weak var fbsigninbtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance()?.presentingViewController = self
        // Automatically sign in the user.
        // GIDSignIn.sharedInstance()?.restorePreviousSignIn()
        GIDSignIn.sharedInstance().delegate = self
        if((GIDSignIn.sharedInstance()?.currentUser) != nil){
            self.addUserInfoViewController()
        }
    }
    
    @IBAction func signInButtonAction(_ sender: Any) {
        GIDSignIn.sharedInstance().delegate=self
        GIDSignIn.sharedInstance().signIn()
    }
    
    @IBAction func fbSignInBtnAction(_ sender: Any) {
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
          if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
            print("The user has not signed in before or they have since signed out.")
          } else {
            print("\(error.localizedDescription)")
          }
          return
        }
        self.addUserInfoViewController()
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        print("Perform any operations when the user disconnects from app here.")
    }
    
    func addUserInfoViewController() {
        let userInfoController = UserInfoViewController.init(nibName: "UserInfoViewController", bundle: nil)
        self.addChild(userInfoController)
        self.view.addSubview(userInfoController.view)
    }
}

