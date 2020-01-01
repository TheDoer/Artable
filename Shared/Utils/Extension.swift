//
//  Extension.swift
//  Artable
//
//  Created by adonis rumbwere on 28/12/2019.
//  Copyright © 2019 Adonis Rumbwere. All rights reserved.
//

import UIKit
import Firebase

extension String {
    var isNotEmpty: Bool {
        return !isEmpty
    }
}

    
    
extension UIViewController {
        
        func simpleAlert(title: String, msg: String) {
            let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }





