//
//  MVHorizontalPicker.swift
//  MVHorizontalPicker
//
//  Created by Andrea Bizzotto on 17/03/2016.
//  Copyright © 2016 musevisions. All rights reserved.
//

import UIKit

private extension UIView {
    
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
        
        return NSLayoutConstraint(item: self, attribute: attribute, relatedBy: .Equal,
            toItem: view, attribute: attribute, multiplier: 1, constant: 0)
    }
}

@IBDesignable public class MVHorizontalPicker: UIControl {
    
    @IBInspectable public var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    @IBInspectable public var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.CGColor
        }
    }
    @IBInspectable public var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        let bundle = NSBundle(forClass: MVHorizontalPicker.self)
        
        if let view = bundle.loadNibNamed("MVHorizontalPicker", owner: self, options: nil).first as? UIView {
            
            self.addSubview(view)
            
            view.anchorToSuperview()
        }
    }
    
    private var _selectedItemIndex: Int = 0
    public var selectedItemIndex: Int {
        get {
            return _selectedItemIndex
        }
        set {
            if newValue != _selectedItemIndex {
                _selectedItemIndex = newValue
                
                updateSelectedIndex(newValue, animated: false)
            }
        }
    }
    
    private var previousItemIndex: Int?
    
    @IBOutlet private var scrollView: UIScrollView!
    
    public var titles: [String]? {
        didSet {
            let titles = self.titles ?? []
            let frame = scrollView.frame
            scrollView.contentSize = CGSize(width: frame.width * CGFloat(titles.count), height: frame.height)
            scrollView.contentOffset = CGPointZero
            
            addContentCells(titles)
        }
    }
    
    private func addContentCells(titles: [String]) {
        
        while let subview = scrollView.subviews.first {
            subview.removeFromSuperview()
        }

        let size = scrollView.frame.size
        var offsetX: CGFloat = 0
        for title in titles {
            let frame = CGRect(x: offsetX, y: CGFloat(0.0), width: size.width, height: size.height)
            let itemView = MVPickerItemView(frame: frame, text: title)
            scrollView.addSubview(itemView)
            offsetX += size.width
        }
        if let firstItemView = scrollView.subviews.first as? MVPickerItemView {
            firstItemView.selected = true
        }
    }
    
    public func setSelectedItemIndex(selectedItemIndex: Int, animated: Bool) {
        if selectedItemIndex != _selectedItemIndex {
            _selectedItemIndex = selectedItemIndex
            
            updateSelectedIndex(selectedItemIndex, animated: animated)
        }
    }
    
    private func updateSelectedIndex(selectedItemIndex: Int, animated: Bool) {
        
        let offset = CGPoint(x: CGFloat(selectedItemIndex) * scrollView.frame.width, y: 0)
        scrollView.setContentOffset(offset, animated: animated)
        
        updateSelection(selectedItemIndex, previousItemIndex: previousItemIndex)
        
        previousItemIndex = selectedItemIndex
    }
    
}

extension MVHorizontalPicker: UIScrollViewDelegate {

    func calculateSelectedItemIndex(scrollView: UIScrollView) -> Int {
        
        let itemWidth = scrollView.frame.width
        let fractionalPage = scrollView.contentOffset.x / itemWidth
        let page = lroundf(Float(fractionalPage))
        return min(scrollView.subviews.count - 1, max(page, 0))
    }

    func updateSelection(selectedItemIndex: Int, previousItemIndex: Int?) {
        
        if let previousItemIndex = previousItemIndex,
            let previousItem = scrollView.subviews[previousItemIndex] as? MVPickerItemView {
                
                previousItem.selected = false
        }
        
        if let currentItem = scrollView.subviews[selectedItemIndex] as? MVPickerItemView {
            
            currentItem.selected = true
        }
    }

    public func scrollViewDidScroll(scrollView: UIScrollView) {
        
        if (scrollView.contentOffset.x < 0.0) {
            return
        }
        
        let selectedItemIndex = calculateSelectedItemIndex(scrollView)
        if selectedItemIndex != previousItemIndex {
            
            updateSelection(selectedItemIndex, previousItemIndex: previousItemIndex)

            previousItemIndex = selectedItemIndex
        }

    }
    
    public func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        let selectedItemIndex = calculateSelectedItemIndex(scrollView)
        if selectedItemIndex != previousItemIndex {
            _selectedItemIndex = selectedItemIndex
            self.sendActionsForControlEvents(.ValueChanged)
        }
    }
}
