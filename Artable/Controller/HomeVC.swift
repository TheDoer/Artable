//
//  ViewController.swift
//  Artable
//
//  Created by adonis rumbwere on 3/12/2019.
//  Copyright © 2019 Adonis Rumbwere. All rights reserved.
//

import UIKit
import Firebase

class HomeVC: UIViewController {
    
    @IBOutlet weak var loginOutBtn: UIBarButtonItem!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //if the current user is not logged in, firebase with anonymously sign in
        if Auth.auth().currentUser == nil {
            Auth.auth().signInAnonymously { (result, error) in
                
                if let error = error {
                    self.handleFireAuthError(error: error)
                    debugPrint(error)
                }
                
            }
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        //We are logged in
        if let user = Auth.auth().currentUser, !user.isAnonymous {
            loginOutBtn.title = "Adonis"
        } else {
            loginOutBtn.title = "Login"
        }
       
    }
    
    fileprivate func presentLoginController() {
        let storyboard = UIStoryboard(name: Storyboard.LoginStoryboard, bundle: nil)
        let controller = storyboard.instantiateViewController(identifier: StoryboardID.LoginVC)
        present(controller, animated: true, completion: nil)
    }
    
    

    @IBAction func loginOutClicked(_ sender: Any) {
        
        guard let user = Auth.auth().currentUser else { return }
        if user.isAnonymous {
            presentLoginController()
        } else {
            
            do {
                try Auth.auth().signOut()
                Auth.auth().signInAnonymously { (result, error) in
                    if let error = error {
                        self.handleFireAuthError(error: error)
                        debugPrint(error)
                    }
                    self.presentLoginController()
                }
            } catch  {
                self.handleFireAuthError(error: error)
                debugPrint(error)
            }
            
        }
        
    }
    
}

