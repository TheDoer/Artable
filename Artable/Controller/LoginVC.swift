//
//  LoginVC.swift
//  Artable
//
//  Created by adonis rumbwere on 27/12/2019.
//  Copyright © 2019 Adonis Rumbwere. All rights reserved.
//

import UIKit
import Firebase

class LoginVC: UIViewController {

    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func forgotPassClicked(_ sender: Any) {
        
        let vc = ForgotPasswordVC()
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true, completion: nil)
        
        
    }
    

    @IBAction func loginClicked(_ sender: Any) {
        
        guard let email = emailTxt.text, email.isNotEmpty,
              let password = passwordTxt.text, password.isNotEmpty else {
                simpleAlert(title: "Error", msg: "Please fill out all fields")
                return
                
        }
        
        activityIndicator.startAnimating()
        
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
          
            // if there is an error
            
            if let error = error {
                debugPrint(error.localizedDescription)
                Auth.auth().handleFireAuthError(error: error, vc:self)
                self.activityIndicator.stopAnimating()
                return
            }
            
            //If there was no error
            
            
            self.activityIndicator.stopAnimating()
            self.dismiss(animated: true, completion: nil)
            
            
        }
        
    }
    
    @IBAction func guestClicked(_ sender: Any) {
    }
    
    
}
