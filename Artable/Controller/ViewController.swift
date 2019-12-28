//
//  ViewController.swift
//  Artable
//
//  Created by adonis rumbwere on 3/12/2019.
//  Copyright © 2019 Adonis Rumbwere. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let storyboard = UIStoryboard(name: Storyboard.LoginStoryboard, bundle: nil)
        let controller = storyboard.instantiateViewController(identifier: StoryboardID.LoginVC)
        present(controller, animated: true, completion: nil)
    }


}

