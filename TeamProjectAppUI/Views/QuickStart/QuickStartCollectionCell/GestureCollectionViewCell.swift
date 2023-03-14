//
//  GestureCollectionViewCell.swift
//  zAR
//
//  Created by doss-zstch1212 on 14/03/23.
//

import UIKit

class GestureCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var gestureTypeLabel: UILabel!
    
    @IBOutlet weak var gestureImgView: UIImageView!
    
    static let identifier = "GestureCollectionViewCell"
    static let nib = UINib(nibName: "GestureCollectionViewCell", bundle: nil)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupGestureCell(_ gesture: Gestures) {
        gestureImgView.image = UIImage(named: gesture.gestureImage)
        gestureTypeLabel.text = gesture.gestureType
    }

}
