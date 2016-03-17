//
//  MVScrollerClipView.swift
//  MVHorizontalPicker
//
//  Created by Andrea Bizzotto on 17/03/2016.
//  Copyright © 2016 musevisions. All rights reserved.
//

import UIKit

class MVScrollerClipView: UIView {

    @IBOutlet var scrollView: UIScrollView!

    // Explained on these posts:
    // http://stackoverflow.com/questions/1677085/paging-uiscrollview-in-increments-smaller-than-frame-size
    // http://stackoverflow.com/questions/1220354/uiscrollview-horizontal-paging-like-mobile-safari-tabs
    override func hitTest(point: CGPoint, withEvent event: UIEvent?) -> UIView? {
        
        return self.pointInside(point, withEvent: event) ? scrollView : nil
    }

}
