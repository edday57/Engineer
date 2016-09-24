//
//  SelectorCell.swift
//  Engineer
//
//  Created by Edward Day on 24/09/2016.
//  Copyright © 2016 Edward Day. All rights reserved.
//

import UIKit

class SelectorCell: UICollectionViewCell {
    @IBOutlet weak var image: UIImageView!
    
    override func awakeFromNib() {
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 1
    }
    
}
