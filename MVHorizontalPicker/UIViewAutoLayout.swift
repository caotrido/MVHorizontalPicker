//
//  UIViewAutoLayout.swift
//  MVHorizontalPicker
//
//  Created by Andrea Bizzotto on 18/03/2016.
//  Copyright © 2016 musevisions. All rights reserved.
//

import UIKit

extension UIView {
    
    func anchorToSuperview() {
        
        if let superview = self.superview {
            self.translatesAutoresizingMaskIntoConstraints = false
            
            superview.addConstraints([
                makeEqualityConstraint(attribute: .Left, toView: superview),
                makeEqualityConstraint(attribute: .Top, toView: superview),
                makeEqualityConstraint(attribute: .Right, toView: superview),
                makeEqualityConstraint(attribute: .Bottom, toView: superview)
                ])
        }
    }
    func makeEqualityConstraint(attribute attribute: NSLayoutAttribute, toView view: UIView) -> NSLayoutConstraint {
        
        return makeConstraint(attribute: attribute, toView: view, constant: 0)
    }
    func makeConstraint(attribute attribute: NSLayoutAttribute, toView view: UIView?, constant: CGFloat) -> NSLayoutConstraint {
        
        return NSLayoutConstraint(item: self, attribute: attribute, relatedBy: .Equal,
            toItem: view, attribute: attribute, multiplier: 1, constant: constant)
    }
}
