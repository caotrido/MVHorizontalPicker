//
//  MVPickerTriangleIndicator.swift
//  MVHorizontalPicker
//
//  Created by Andrea Bizzotto on 19/03/2016.
//  Copyright © 2016 musevisions. All rights reserved.
//

import UIKit

class MVPickerTriangleIndicator: UIView {
    
    override var tintColor: UIColor! {
        didSet {
            triangleShape.strokeColor = tintColor.CGColor
            triangleShape.fillColor = tintColor.CGColor
        }
    }
    
    private let triangleShape: CAShapeLayer
    
    required init?(coder aDecoder: NSCoder) {
        triangleShape = CAShapeLayer()
        super.init(coder: aDecoder)
        
        let width = layer.frame.size.width
        let height = layer.frame.size.height
        
        let path = CGPathCreateMutable()
        
        CGPathMoveToPoint(path, nil, 0, 0)
        CGPathAddLineToPoint(path, nil, width/2, height)
        CGPathAddLineToPoint(path, nil, width, 0)
        CGPathAddLineToPoint(path, nil, 0, 0)
        
        triangleShape.frame = self.bounds
        triangleShape.path = path
        triangleShape.lineWidth = 1.0
        
        self.layer.insertSublayer(triangleShape, atIndex: 0)
    }
}
