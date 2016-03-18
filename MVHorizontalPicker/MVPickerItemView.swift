//
//  MVPickerItemView.swift
//  MVHorizontalPicker
//
//  Created by Andrea Bizzotto on 17/03/2016.
//  Copyright © 2016 musevisions. All rights reserved.
//

import UIKit

@objc class MVPickerItemView: UILabel {

    var selected: Bool = false {
        didSet {
            updateTextColor(selected: selected)
        }
    }
    
    var selectedTextColor: UIColor {
        didSet {
            updateTextColor(selected: selected)
        }
    }

    init(frame: CGRect, text: String, selectedTextColor: UIColor, font: UIFont?) {
        
        self.selectedTextColor = selectedTextColor
        super.init(frame: frame)
        self.text = text
        
        self.font = font
        self.backgroundColor = UIColor.clearColor()
        self.textAlignment = NSTextAlignment.Center
        
        updateTextColor(selected: false)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    func updateTextColor(selected selected: Bool) {
        
        let alpha: CGFloat = selected ? 1.0 : 0.5
        self.textColor = selectedTextColor.colorWithAlphaComponent(alpha)
    }
}
