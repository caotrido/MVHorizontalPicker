//
//  MVPickerItemView.swift
//  MVHorizontalPicker
//
//  Created by Andrea Bizzotto on 17/03/2016.
//  Copyright © 2016 musevisions. All rights reserved.
//

import UIKit

@objc class MVPickerItemView: UIView {

    let label: UILabel
    
    var selected: Bool = false {
        didSet {
            updateTextColor(selected: selected)
        }
    }
    
    override var tintColor: UIColor! {
        didSet {
            updateTextColor(selected: selected)
        }
    }
    
    var font: UIFont? {
        get {
            return label.font
        }
        set {
            label.font = newValue
        }
    }

    init(text: String, font: UIFont?) {
        
        self.label = UILabel()
        
        super.init(frame: CGRectZero)
        addLabel(label)
        label.text = text
        label.font = font
        label.textAlignment = NSTextAlignment.Center
        label.lineBreakMode = .ByTruncatingMiddle
        
        updateTextColor(selected: false)
    }
    
    func addLabel(label: UILabel) {
        self.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        self.addConstraint(label.makeEqualityConstraint(attribute: .Leading, toView: self))
        self.addConstraint(label.makeEqualityConstraint(attribute: .Trailing, toView: self))
        self.addConstraint(label.makeEqualityConstraint(attribute: .CenterY, toView: self))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    func updateTextColor(selected selected: Bool) {
        
        let alpha: CGFloat = selected ? 1.0 : 0.5
        self.label.textColor = tintColor.colorWithAlphaComponent(alpha)
    }
}
