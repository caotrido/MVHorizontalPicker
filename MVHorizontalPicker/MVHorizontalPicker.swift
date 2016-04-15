/*
MVHorizontalPicker - Copyright (c) 2016 Andrea Bizzotto bizz84@gmail.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

import UIKit

@IBDesignable public class MVHorizontalPicker: UIControl {
    
    @IBInspectable public var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
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
    
    @IBInspectable public var font: UIFont? {
        didSet {
            for view in scrollView.subviews {
                if let item = view as? MVPickerItemView {
                    item.font = font
                }
            }
        }
    }
    
    @IBInspectable public var edgesGradientWidth: CGFloat = 0 {
        didSet {
            updateGradient(frame: self.bounds, edgesGradientWidth: edgesGradientWidth)
        }
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        updateGradient(frame: self.bounds, edgesGradientWidth: edgesGradientWidth)
    }
    
    private func updateGradient(frame frame: CGRect, edgesGradientWidth: CGFloat) {
        
        if edgesGradientWidth > 0 && frame.width > 0 {
            let gradient = CAGradientLayer()
            gradient.frame = frame
            let clearColor = UIColor.clearColor().CGColor
            let backgroundColor = UIColor.whiteColor().CGColor
            gradient.colors = [ clearColor, backgroundColor, backgroundColor, clearColor ]
            let gradientWidth = edgesGradientWidth / frame.width
            gradient.locations = [ 0, gradientWidth, 1 - gradientWidth, 1]
            gradient.startPoint = CGPointZero
            gradient.endPoint = CGPointMake(1, 0)
            self.layer.mask = gradient
        }
        else {
            self.layer.mask = nil
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
    
    override public var tintColor: UIColor! {
        didSet {
            triangleIndicator?.tintColor = self.tintColor
            layer.borderColor = tintColor?.CGColor
            let _ = scrollView?.subviews.map{ $0.tintColor = tintColor }
        }
    }
    
    @IBOutlet private var scrollView: UIScrollView!
    @IBOutlet private var scrollViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet private var triangleIndicator: MVPickerTriangleIndicator!
    @IBOutlet private var leftGradientHolder: UIView!

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
            
            triangleIndicator.tintColor = self.tintColor
            layer.borderColor = self.tintColor.CGColor
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
    }

    private func reloadSubviews(titles titles: [String]) {
        
        let size = scrollView.frame.size

        // Remove all subviews
        while let first = scrollView.subviews.first {
            first.removeFromSuperview()
        }

        let holder = scrollView.superview!
        var offsetX: CGFloat = 0
        for title in titles {
            let itemView = MVPickerItemView(text: title, font: font)
            scrollView.addSubview(itemView)
            itemView.tintColor = self.tintColor

            itemView.translatesAutoresizingMaskIntoConstraints = false
            itemView.addConstraint(itemView.makeConstraint(attribute: .Width, toView: nil, constant: size.width))
            scrollView.addConstraint(itemView.makeConstraint(attribute: .Leading, toView: scrollView, constant: offsetX))
            scrollView.addConstraint(itemView.makeEqualityConstraint(attribute: .Top, toView: scrollView))
            scrollView.addConstraint(itemView.makeEqualityConstraint(attribute: .Bottom, toView: scrollView))
            holder.addConstraint(itemView.makeEqualityConstraint(attribute: .Height, toView: holder))
            
            offsetX += size.width
        }
        
        if let last = scrollView.subviews.last {
            scrollView.addConstraint(last.makeConstraint(attribute: .Trailing, toView: scrollView, constant: 0))
        }
        scrollView.contentInset = UIEdgeInsetsZero
        scrollView.contentOffset = CGPointZero
    }
    
    public func setSelectedItemIndex(selectedItemIndex: Int, animated: Bool) {
        if selectedItemIndex != _selectedItemIndex {
            _selectedItemIndex = selectedItemIndex
            
            updateSelectedIndex(selectedItemIndex, animated: animated)
        }
    }
    
    private func updateSelectedIndex(selectedItemIndex: Int, animated: Bool) {
        
        if scrollView.contentSize != CGSizeZero {
            let offset = CGPoint(x: CGFloat(selectedItemIndex) * scrollView.frame.width, y: 0)
            scrollView.setContentOffset(offset, animated: animated)
            
            updateSelection(selectedItemIndex, previousItemIndex: previousItemIndex)
            
            previousItemIndex = selectedItemIndex
        }
    }

    // MARK: KVO
    private var myContext = 0xDEADC0DE
    public override func awakeFromNib() {
        super.awakeFromNib()
        scrollView.addObserver(self, forKeyPath: "contentSize", options: .New, context: &myContext)
    }
    override public func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if context == &myContext {
            if let newValue = change?[NSKeyValueChangeNewKey] {
                if newValue.CGSizeValue() != CGSizeZero {
                    updateSelectedIndex(_selectedItemIndex, animated: false)
                }
            }
        }
        else {
            super.observeValueForKeyPath(keyPath, ofObject: object, change: change, context: context)
        }
    }
    
    deinit {
        scrollView.removeObserver(self, forKeyPath: "contentSize", context: &myContext)
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
