//
//  CategoryCell.swift
//  Artable
//
//  Created by adonis rumbwere on 31/12/2019.
//  Copyright © 2019 Adonis Rumbwere. All rights reserved.
//

import UIKit
import Kingfisher

class CategoryCell: UICollectionViewCell {

    @IBOutlet weak var categoryImg: UIImageView!
    @IBOutlet weak var categoryLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        categoryImg.layer.cornerRadius = 5
    }
    
    func configureCell(category: Category){
        categoryLbl.text = category.name
        if let url = URL(string: category.imgUrl){
            categoryImg.kf.setImage(with: url)
        }
        
        
    }

}
