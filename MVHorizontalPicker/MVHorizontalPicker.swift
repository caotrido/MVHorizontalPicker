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
    
    private func updateGradient(frame: CGRect, edgesGradientWidth: CGFloat) {
        
        if edgesGradientWidth > 0 && frame.width > 0 {
            let gradient = CAGradientLayer()
            gradient.frame = frame
            let clearColor = UIColor.clear.cgColor
            let backgroundColor = UIColor.white.cgColor
            gradient.colors = [ clearColor, backgroundColor, backgroundColor, clearColor ]
            let gradientWidth = edgesGradientWidth / frame.width
            gradient.locations = [ 0, gradientWidth, 1 - gradientWidth, 1]
            gradient.startPoint = CGPoint.zero
            gradient.endPoint = CGPoint(x: 1, y: 0)
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
            layer.borderColor = tintColor?.cgColor
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
        
        let bundle = Bundle(for: MVHorizontalPicker.self)
        
        if let view = bundle.loadNibNamed("MVHorizontalPicker", owner: self, options: nil)?.first as? UIView {
            
            self.addSubview(view)
            
            view.anchorToSuperview()
            
            triangleIndicator.tintColor = self.tintColor
            layer.borderColor = self.tintColor.cgColor
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        rendersInInterfaceBuilder = true
    }

    private func reloadSubviews(titles: [String]) {
        
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
            itemView.addConstraint(itemView.makeConstraint(attribute: .width, toView: nil, constant: size.width))
            scrollView.addConstraint(itemView.makeConstraint(attribute: .leading, toView: scrollView, constant: offsetX))
            scrollView.addConstraint(itemView.makeEqualityConstraint(attribute: .top, toView: scrollView))
            scrollView.addConstraint(itemView.makeEqualityConstraint(attribute: .bottom, toView: scrollView))
            holder.addConstraint(itemView.makeEqualityConstraint(attribute: .height, toView: holder))
            
            offsetX += size.width
        }
        
        if let last = scrollView.subviews.last {
            scrollView.addConstraint(last.makeConstraint(attribute: .trailing, toView: scrollView, constant: 0))
        }
        scrollView.contentInset = UIEdgeInsets.zero
        scrollView.contentOffset = CGPoint.zero
    }
    
    public func setSelectedItemIndex(_ selectedItemIndex: Int, animated: Bool) {
        if selectedItemIndex != _selectedItemIndex {
            _selectedItemIndex = selectedItemIndex
            
            updateSelectedIndex(selectedItemIndex, animated: animated)
        }
    }
    
    private func updateSelectedIndex(_ selectedItemIndex: Int, animated: Bool) {
        
        if scrollView.contentSize != CGSize.zero {
            let offset = CGPoint(x: CGFloat(selectedItemIndex) * scrollView.frame.width, y: 0)
            scrollView.setContentOffset(offset, animated: animated)
            
            updateSelection(selectedItemIndex, previousItemIndex: previousItemIndex)
            
            previousItemIndex = selectedItemIndex
        }
    }

    // MARK: KVO
    private var rendersInInterfaceBuilder = false
    private var myContext: UInt = 0xDEADC0DE
    public override func awakeFromNib() {
        super.awakeFromNib()
        if !rendersInInterfaceBuilder {
            scrollView.addObserver(self, forKeyPath: "contentSize", options: .new, context: &myContext)
        }
    }
    override public func observeValue(forKeyPath keyPath: String?, of object: AnyObject?, change: [NSKeyValueChangeKey : AnyObject]?, context: UnsafeMutablePointer<Void>?) {
        if rendersInInterfaceBuilder {
            return
        }
        if context == &myContext {
            if let newValue = change?[NSKeyValueChangeKey.newKey] {
                if newValue.cgSizeValue != CGSize.zero {
                    updateSelectedIndex(_selectedItemIndex, animated: false)
                }
            }
        }
        else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }
    
    deinit {
        if !rendersInInterfaceBuilder {
            scrollView.removeObserver(self, forKeyPath: "contentSize", context: &myContext)
        }
    }
}

extension MVHorizontalPicker: UIScrollViewDelegate {

    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        updateSelectedItem(scrollView)
    }
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let selectedItemIndex = updateSelectedItem(scrollView)
        
        if selectedItemIndex != _selectedItemIndex {
            
            _selectedItemIndex = selectedItemIndex
            
            self.sendActions(for: .valueChanged)
        }
    }

    private func calculateSelectedItemIndex(_ scrollView: UIScrollView) -> Int {
        
        let itemWidth = scrollView.frame.width
        let fractionalPage = scrollView.contentOffset.x / itemWidth
        let page = lroundf(Float(fractionalPage))
        return min(scrollView.subviews.count - 1, max(page, 0))
    }

    private func updateSelection(_ selectedItemIndex: Int, previousItemIndex: Int?) {
        
        if let previousItemIndex = previousItemIndex,
            let previousItem = scrollView.subviews[previousItemIndex] as? MVPickerItemView {
                
                previousItem.selected = false
        }
        
        if let currentItem = scrollView.subviews[selectedItemIndex] as? MVPickerItemView {
            
            currentItem.selected = true
        }
    }

    private func updateSelectedItem(_ scrollView: UIScrollView) -> Int {
        
        let selectedItemIndex = calculateSelectedItemIndex(scrollView)

        if selectedItemIndex != previousItemIndex {
            
            updateSelection(selectedItemIndex, previousItemIndex: previousItemIndex)
            
            previousItemIndex = selectedItemIndex
        }
        return selectedItemIndex
    }
}
