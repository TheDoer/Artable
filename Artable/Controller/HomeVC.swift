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
    
    let backgroundImageView = UIImageView()
    
    @IBOutlet weak var loginOutBtn: UIBarButtonItem!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setBackground()
        
        
        
        //if the current user is not logged in, firebase with anonymously sign in
        if Auth.auth().currentUser == nil {
            Auth.auth().signInAnonymously { (result, error) in
                
                if let error = error {
                    Auth.auth().handleFireAuthError(error: error, vc: self)
                    debugPrint(error)
                }
                
            }
        }
        
    
        
    }
    
    func setBackground(){
        view.addSubview(backgroundImageView)
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = false
        backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = false
        backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = false
        backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = false
        backgroundImageView.image = UIImage(named: "bg_cat3")
        backgroundImageView.contentMode = .scaleAspectFill
        view.sendSubviewToBack(backgroundImageView)
        
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        //We are logged in
        if let user = Auth.auth().currentUser, !user.isAnonymous {
            loginOutBtn.title = "Logout"
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
                        Auth.auth().handleFireAuthError(error: error, vc:self)
                        debugPrint(error)
                    }
                    self.presentLoginController()
                }
            } catch  {
                Auth.auth().handleFireAuthError(error: error, vc:self)
                debugPrint(error)
            }
            
        }
        
    }
    
}

