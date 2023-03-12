//
//  UIView+Extension.swift
//  zAR
//
//  Created by doss-zstch1212 on 10/03/23.
//

import UIKit

extension UIView{
    @IBInspectable var cornerRadius: CGFloat {
        get { return cornerRadius}
        
        set {
            self.layer.cornerRadius = newValue
        }
    }
}
