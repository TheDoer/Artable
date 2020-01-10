//
//  Category.swift
//  Artable
//
//  Created by adonis rumbwere on 31/12/2019.
//  Copyright © 2019 Adonis Rumbwere. All rights reserved.
//

import Foundation
import FirebaseFirestore

struct Category {
    var name: String
    var id: String
    var imgUrl: String
    var isActive:Bool = true
    var timeStamp: Timestamp
    
    
}
