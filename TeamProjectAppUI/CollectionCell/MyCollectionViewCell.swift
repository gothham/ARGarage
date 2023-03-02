//
//  MyCollectionViewCell.swift
//  TeamProjectAppUI
//
//  Created by sonai-zstch1129 on 21/02/23.
//

import UIKit

class MyCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet var myImageview : UIImageView!
    
    static let identifier = "MyCollectionViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "MyCollectionViewCell", bundle: nil)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    public func configure(with model: Model){
        self.myImageview.image = UIImage(named: model.imageName)
    }
}
