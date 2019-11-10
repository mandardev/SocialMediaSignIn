//
//  ViewController.swift
//  SocialMediaLogin
//
//  Created by Mandar Choudhary on 09/11/19.
//  Copyright © 2019 Mandar Choudhary. All rights reserved.
//

import UIKit
import GoogleSignIn
import FBSDKCoreKit
import FBSDKLoginKit

class ViewController: UIViewController, GIDSignInDelegate {

    @IBOutlet weak var gmailSignInButton: UIButton!
    
    @IBOutlet weak var fbsigninbtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance().delegate = self
        // Automatically sign in the user.
        // GIDSignIn.sharedInstance()?.restorePreviousSignIn()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if((GIDSignIn.sharedInstance()?.currentUser) != nil){
            self.addUserInfoViewController()
        }else if (AccessToken.current != nil){
            self.addUserInfoViewController()
        }
    }
    
    func addUserInfoViewController() {
        let userInfoController = UserInfoViewController.init(nibName: "UserInfoViewController", bundle: nil)
        self.addChild(userInfoController)
        self.view.addSubview(userInfoController.view)
    }
    
// MARK:- Gmail Sign-in Methods :
    
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
    
    @IBAction func signInButtonAction(_ sender: Any) {
        GIDSignIn.sharedInstance().delegate=self
        GIDSignIn.sharedInstance().signIn()
    }
    
// MARK:- Facebook Sign-in Methods :
    
    @IBAction func fbSignInBtnAction(_ sender: Any) {
        let fbLoginManager : LoginManager = LoginManager()
        fbLoginManager.logIn(permissions: ["email"], from: self) { (result, error) -> Void in
             if (error == nil){
               let fbloginresult : LoginManagerLoginResult = result!
               // if user cancel the login
               if (result?.isCancelled)!{
                       return
               }
               if(fbloginresult.grantedPermissions.contains("email"))
               {
                 self.getFBUserData()
               }
             }
        }
    }
    
    func getFBUserData(){
        if((AccessToken.current) != nil){
         GraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
           if (error == nil){
            self.addUserInfoViewController()
            print(result as Any)
           }
         })
       }
     }
}

