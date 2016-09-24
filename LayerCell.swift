//
//  LayerCell.swift
//  Engineer
//
//  Created by Edward Day on 23/09/2016.
//  Copyright © 2016 Edward Day. All rights reserved.
//

import UIKit

class LayerCell: UICollectionViewCell {
    
    let lightBlack = UIColor(colorLiteralRed: 0.1, green: 0.1, blue: 0.1, alpha: 1)
    
    override func awakeFromNib() {
        self.layer.borderWidth = 1
        self.layer.borderColor = lightBlack.cgColor
    }
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var layerLabel: UILabel!
    
    
    
    
}
