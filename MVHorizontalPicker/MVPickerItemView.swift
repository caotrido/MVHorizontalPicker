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
            
            let white: CGFloat = selected ? 0.2 : 0.5
            self.textColor = UIColor(white: white, alpha: 1.0)
        }
    }

    init(frame: CGRect, text: String) {
        
        super.init(frame: frame)
        self.text = text
        
        self.font = UIFont.boldSystemFontOfSize(12)
        self.backgroundColor = UIColor.clearColor()
        self.textAlignment = NSTextAlignment.Center
        
        self.layer.shadowOffset = CGSizeMake(0.0, 2.5)
        self.layer.shadowOpacity = 0.15
        self.layer.shadowRadius = 2.5
        
        self.selected = false
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
