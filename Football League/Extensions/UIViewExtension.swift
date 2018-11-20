//
//  UIViewExtension.swift
//  Football League
//
//  Created by Arabia-IT on 11/18/18.
//  Copyright © 2018 Arabia-IT. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get
        {
            return layer.cornerRadius
        }
        set (newRadius)
        {
            if newRadius >= 0
            {
                layer.cornerRadius = newRadius
            }
            else
            {
                layer.cornerRadius = 0
            }
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get
        {
            return layer.borderWidth
        }
        set (newWidth)
        {
            if newWidth >= 0
            {
                layer.borderWidth = newWidth
            }
            else
            {
                layer.borderWidth = 0
            }
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get
        {
            if let _ = layer.borderColor
            {
                return UIColor(cgColor: layer.borderColor!)
            }
            else
            {
                return UIColor()
            }
            
        }
        set (newColor)
        {
            layer.borderColor = newColor?.cgColor
        }
    }
}


