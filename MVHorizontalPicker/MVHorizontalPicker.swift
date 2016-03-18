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
    
    @IBInspectable public var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    @IBInspectable public var borderColor: UIColor? {
        get {
            return layer.borderColor != nil ? UIColor(CGColor: layer.borderColor!) : nil
        }
        set {
            layer.borderColor = newValue?.CGColor
        }
    }
    @IBInspectable public var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable public var textColor: UIColor! = UIColor.blackColor() {
        didSet {
            let _ = scrollView?.subviews.map { ($0 as? MVPickerItemView)?.selectedTextColor = textColor }
        }
    }
    
    @IBInspectable public var font: UIFont? {
        didSet {
            for view in scrollView.subviews {
                if let item = view as? MVPickerItemView {
                    item.font = font
                }
            }
        }
    }
    
    public var itemWidth: CGFloat {
        get {
            return scrollViewWidthConstraint.constant
        }
        set {
            scrollViewWidthConstraint.constant = newValue
            self.layoutIfNeeded()
            if titles.count > 0 {
                reloadSubviews(titles: titles)
                updateSelectedIndex(_selectedItemIndex, animated: false)
            }
        }
    }
    
    @IBOutlet private var scrollView: UIScrollView!
    @IBOutlet private var scrollViewWidthConstraint: NSLayoutConstraint!

    private var previousItemIndex: Int?

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
    
    
    public var titles: [String] = [] {
        didSet {
            
            reloadSubviews(titles: titles)
            
            if let firstItemView = scrollView.subviews.first as? MVPickerItemView {
                firstItemView.selected = true
            }

            previousItemIndex = 0
            _selectedItemIndex = 0
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
    }

    private func reloadSubviews(titles titles: [String]) {
        
        let frame = scrollView.frame
        scrollView.contentSize = CGSize(width: frame.width * CGFloat(titles.count), height: frame.height)
        scrollView.contentOffset = CGPointZero

        while let subview = scrollView.subviews.first {
            subview.removeFromSuperview()
        }

        let size = scrollView.frame.size
        var offsetX: CGFloat = 0
        for title in titles {
            let frame = CGRect(x: offsetX, y: CGFloat(0.0), width: size.width, height: size.height)
            let itemView = MVPickerItemView(frame: frame, text: title, selectedTextColor: textColor, font: font)
            scrollView.addSubview(itemView)
            offsetX += size.width
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

    public func scrollViewDidScroll(scrollView: UIScrollView) {
        
        updateSelectedItem(scrollView)
    }
    
    public func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        let selectedItemIndex = updateSelectedItem(scrollView)
        
        if selectedItemIndex != _selectedItemIndex {
            
            _selectedItemIndex = selectedItemIndex
            
            self.sendActionsForControlEvents(.ValueChanged)
        }
    }

    private func calculateSelectedItemIndex(scrollView: UIScrollView) -> Int {
        
        let itemWidth = scrollView.frame.width
        let fractionalPage = scrollView.contentOffset.x / itemWidth
        let page = lroundf(Float(fractionalPage))
        return min(scrollView.subviews.count - 1, max(page, 0))
    }

    private func updateSelection(selectedItemIndex: Int, previousItemIndex: Int?) {
        
        if let previousItemIndex = previousItemIndex,
            let previousItem = scrollView.subviews[previousItemIndex] as? MVPickerItemView {
                
                previousItem.selected = false
        }
        
        if let currentItem = scrollView.subviews[selectedItemIndex] as? MVPickerItemView {
            
            currentItem.selected = true
        }
    }

    private func updateSelectedItem(scrollView: UIScrollView) -> Int {
        
        let selectedItemIndex = calculateSelectedItemIndex(scrollView)
        if selectedItemIndex != previousItemIndex {
            
            updateSelection(selectedItemIndex, previousItemIndex: previousItemIndex)
            
            previousItemIndex = selectedItemIndex
        }
        return selectedItemIndex
    }
}
