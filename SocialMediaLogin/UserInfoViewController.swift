//
//  UserInfoViewController.swift
//  SocialMediaLogin
//
//  Created by Mandar Choudhary on 09/11/19.
//  Copyright © 2019 Mandar Choudhary. All rights reserved.
//

import UIKit
import GoogleSignIn

class UserInfoViewController: UIViewController {

    @IBOutlet weak var signOutBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func signOutBtnAction(_ sender: Any) {
        GIDSignIn.sharedInstance().signOut()
        GIDSignIn.sharedInstance()?.disconnect()
        self.view.removeFromSuperview()
    }

}
