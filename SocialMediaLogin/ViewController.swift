//
//  ViewController.swift
//  SocialMediaLogin
//
//  Created by Mandar Choudhary on 09/11/19.
//  Copyright © 2019 Mandar Choudhary. All rights reserved.
//

import UIKit
import GoogleSignIn

class ViewController: UIViewController {

    @IBAction func btnAction(_ sender: Any) {
        GIDSignIn.sharedInstance().signOut()

    }
    @IBOutlet weak var btn: UIButton!
    @IBOutlet weak var gmailSignInButton: GIDSignInButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance()?.presentingViewController = self

        // Automatically sign in the user.
        GIDSignIn.sharedInstance()?.restorePreviousSignIn()

        // ...
        // Do any additional setup after loading the view.
    }


}

