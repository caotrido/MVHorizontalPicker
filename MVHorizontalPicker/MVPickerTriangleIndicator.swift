/*
MVHorizontalPicker - Copyright (c) 2016 Andrea Bizzotto bizz84@gmail.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

import UIKit

open class MVPickerTriangleIndicator: UIView {
    
    fileprivate let width: CGFloat = 12.0
    fileprivate let height: CGFloat = 7.0

    override open var tintColor: UIColor! {
        didSet {
            triangleShape.strokeColor = tintColor.cgColor
            triangleShape.fillColor = tintColor.cgColor
        }
    }
    
    fileprivate let triangleShape: CAShapeLayer
    
    required public init?(coder aDecoder: NSCoder) {
        triangleShape = CAShapeLayer()
        super.init(coder: aDecoder)
        
        let path = CGMutablePath()
        
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: width/2, y: height))
        path.addLine(to: CGPoint(x: width, y: 0))
        path.addLine(to: CGPoint(x: 0, y: 0))
        
        triangleShape.frame = self.bounds
        triangleShape.path = path
        triangleShape.lineWidth = 1.0
        
        self.layer.insertSublayer(triangleShape, at: 0)
    }
}
