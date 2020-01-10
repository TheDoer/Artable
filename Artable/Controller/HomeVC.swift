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
    
    
    
    //let backgroundImageView = UIImageView()
    
    @IBOutlet weak var loginOutBtn: UIBarButtonItem!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    //varibles
    
    var catergories = [Category]()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let category = Category.init(name: "Safari", id: "tryingthithing", imgUrl: "https://images.unsplash.com/photo-1521651201144-634f700b36ef?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60", isActive: true, timeStamp: Timestamp())
        catergories.append(category)
        
         //setBackground()
        // Do any additional setup after loading the view.
        
        //setting up delegates
        collectionView?.delegate = self
        collectionView?.dataSource = self
        
        //For the app to know which view to display, we register the  nibs/xibs below
        //Now it knows which type of collection view it it supposed to display
        collectionView?.register(UINib(nibName: Identifiers.CategoryCell, bundle: nil), forCellWithReuseIdentifier: Identifiers.CategoryCell)
        
    
        
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
    // Setting up background image pragmatically 
//    func setBackground(){
//        view.addSubview(backgroundImageView)
//        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
//        backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = false
//        backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = false
//        backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = false
//        backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = false
//        backgroundImageView.image = UIImage(named: "bg_cat3")
//        backgroundImageView.contentMode = .scaleAspectFill
//        view.sendSubviewToBack(backgroundImageView)
//
//    }
    
    
    
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

extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return catergories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifiers.CategoryCell, for: indexPath) as? CategoryCell {
            cell.configureCell(category: catergories[indexPath.item])
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = view.frame.width
        let cellWidth = (width - 50)/2
        let cellHeight = (cellWidth * 1.5)
        
        return CGSize(width: cellWidth, height: cellHeight)
        
        
    }
    
    
    
}





