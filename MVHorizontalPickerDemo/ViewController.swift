//
//  ViewController.swift
//  MVHorizontalPickerDemo
//
//  Created by Andrea Bizzotto on 17/03/2016.
//  Copyright © 2016 musevisions. All rights reserved.
//

import UIKit
import MVHorizontalPicker

class ViewController: UIViewController {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var picker: MVHorizontalPicker!
    
    
    @IBOutlet var itemWidthSelector: UISegmentedControl!
    @IBOutlet var fontSizeSelector: UISegmentedControl!
    @IBOutlet var borderWidthSelector: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        picker.titles = [ "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday" ]

        picker.itemWidth = itemWidth(itemWidthSelector)

        picker.font = UIFont.boldSystemFontOfSize(fontSize(fontSizeSelector))
        
        picker.borderWidth = borderWidth(borderWidthSelector)

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
}

