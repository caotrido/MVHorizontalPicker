/*
MVHorizontalPicker - Copyright (c) 2016 Andrea Bizzotto bizz84@gmail.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/


import UIKit
import MVHorizontalPicker

class ViewController: UIViewController {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var picker: MVHorizontalPicker!
    
    
    @IBOutlet var itemWidthSelector: UISegmentedControl!
    @IBOutlet var fontSizeSelector: UISegmentedControl!
    @IBOutlet var borderWidthSelector: UISegmentedControl!
    @IBOutlet var tintColorSelector: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        picker.titles = [ "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday" ]

        picker.itemWidth = itemWidth(itemWidthSelector)

        picker.font = UIFont.boldSystemFontOfSize(fontSize(fontSizeSelector))
        
        picker.borderWidth = borderWidth(borderWidthSelector)
        
        picker.tintColor = tintColor(tintColorSelector)

        updateLabel()
    }
    
    @IBAction func pickerValueChanged(sender: AnyObject) {

        updateLabel()
    }
    
    func updateLabel() {
        
        titleLabel.text = picker.titles[picker.selectedItemIndex]
        //print("index: \(picker.selectedItemIndex), title: \(title)")
    }

    @IBAction func itemWidthChanged(sender: AnyObject) {

        picker.itemWidth = itemWidth(itemWidthSelector)
    }

    @IBAction func fontSizeChanged(sender: AnyObject) {
        
        picker.font = UIFont.boldSystemFontOfSize(fontSize(fontSizeSelector))
    }
    
    @IBAction func borderWidthChanged(sender: AnyObject) {
        
        picker.borderWidth = borderWidth(borderWidthSelector)
    }
    @IBAction func tintColorChanged(sender: AnyObject) {
        
        picker.tintColor = tintColor(tintColorSelector)
    }

    func itemWidth(itemWidthSelector: UISegmentedControl) -> CGFloat {
        switch itemWidthSelector.selectedSegmentIndex {
        case 0: return 100
        case 1: return 125
        case 2: return 150
        default: return 100
        }
    }
    
    func fontSize(fontSizeSelector: UISegmentedControl) -> CGFloat {
        switch fontSizeSelector.selectedSegmentIndex {
        case 0: return 14.0
        case 1: return 16.0
        case 2: return 18.0
        default: return 18.0
        }
    }
    
    func borderWidth(borderWidthSelector: UISegmentedControl) -> CGFloat {
        return CGFloat(borderWidthSelector.selectedSegmentIndex)
    }
    
    func tintColor(tintColorSelector: UISegmentedControl) -> UIColor {
        switch tintColorSelector.selectedSegmentIndex {
        case 0: return UIColor(red: 15.0/255.0, green: 164.0/255.0, blue: 69.0/255.0, alpha: 1.0)
        case 1: return UIColor(red: 0.0, green: 128.0/255.0, blue: 1.0, alpha: 1.0)
        case 2: return UIColor.blackColor()
        default: return UIColor.blackColor()
        }
    }
}

