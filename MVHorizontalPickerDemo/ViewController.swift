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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        picker.font = UIFont.boldSystemFontOfSize(18)
    
        picker.titles = [ "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday" ]

        picker.itemWidth = itemWidth(itemWidthSelector)

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
    
    func itemWidth(itemWidthSelector: UISegmentedControl) -> CGFloat {
        switch itemWidthSelector.selectedSegmentIndex {
        case 0: return 100
        case 1: return 125
        case 2: return 150
        default: return 100
        }
    }
}

