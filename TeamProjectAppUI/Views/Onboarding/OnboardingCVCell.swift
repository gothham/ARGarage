//
//  OnboardingCVCell.swift
//  zAR
//
//  Created by doss-zstch1212 on 10/03/23.
//

import UIKit

class OnboardingCVCell: UICollectionViewCell {
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var sliderImageView: UIImageView!
    
    func setupOnboarding(_ slide: OnboardingSlide) {
        sliderImageView.image = UIImage(named: slide.image)
        titleLabel.text = slide.title
        descriptionLabel.text = slide.description
    }
    
    
}
