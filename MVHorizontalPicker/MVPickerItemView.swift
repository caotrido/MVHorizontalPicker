//
//  MVPickerItemView.swift
//  MVHorizontalPicker
//
//  Created by Andrea Bizzotto on 17/03/2016.
//  Copyright © 2016 musevisions. All rights reserved.
//

import UIKit

class MVPickerItemView: UILabel {

    var selected: Bool = false {
        didSet {
            updateTextColor(selected: selected)
        }
    }

    init(frame: CGRect, text: String, font: UIFont?) {
        
        super.init(frame: frame)
        self.text = text
        
        self.font = font
        self.backgroundColor = UIColor.clearColor()
        self.textAlignment = NSTextAlignment.Center
        
//        self.layer.shadowOffset = CGSizeMake(0.0, 2.5)
//        self.layer.shadowOpacity = 0.15
//        self.layer.shadowRadius = 2.5
        
        updateTextColor(selected: false)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateTextColor(selected selected: Bool) {
        
        let white: CGFloat = selected ? 0.2 : 0.5
        self.textColor = UIColor(white: white, alpha: 1.0)
    }
}
