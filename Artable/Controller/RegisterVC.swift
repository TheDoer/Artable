//
//  RegisterVC.swift
//  Artable
//
//  Created by adonis rumbwere on 27/12/2019.
//  Copyright © 2019 Adonis Rumbwere. All rights reserved.
//

import UIKit
import Firebase

class RegisterVC: UIViewController {
    
    
      //MARK: Register Outlets
    
    @IBOutlet weak var usernameTxt: UITextField!
    
    @IBOutlet weak var emailTxt: UITextField!
    
    @IBOutlet weak var passwordTxt: UITextField!
    
    @IBOutlet weak var confirmPasswordTxt: UITextField!
    
    @IBOutlet weak var passCheckImg: UIImageView!
    @IBOutlet weak var confirmPassCheckImg: UIImageView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
  
    }
    
    @IBAction func registerClicked(_ sender: Any) {
        guard let email = emailTxt.text, email.isNotEmpty,
            let username = usernameTxt.text,username.isNotEmpty,
            let password = passwordTxt.text, username.isNotEmpty else { return }
        
        activityIndicator.startAnimating()
            
            
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            
            if let error = error {
                debugPrint(error)
                return
            }
            self.activityIndicator.stopAnimating()
            
            print("Successfully Registered")
        }
        
        
    }
    
}
