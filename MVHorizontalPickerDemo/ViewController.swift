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

    @IBOutlet var maximumCacheSizeLabel: UILabel!
    @IBOutlet var picker: MVHorizontalPicker!
    @IBOutlet var itemWidthSelector: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        picker.font = UIFont.boldSystemFontOfSize(18)
    
        picker.titles = [ "100MB", "200MB", "500MB", "1GB", "2GB", "5GB" ]
        
        picker.itemWidth = itemWidth(itemWidthSelector)

        updateLabel()
    }

    @IBAction func pickerValueChanged(sender: AnyObject) {

        updateLabel()
    }
    
    func updateLabel() {
        
        let title = picker.titles[picker.selectedItemIndex]
        maximumCacheSizeLabel.text = "Maximum Cache Size: \(title)"
        //print("index: \(picker.selectedItemIndex), title: \(title)")
    }

    @IBAction func itemWidthChanged(sender: AnyObject) {

        picker.itemWidth = itemWidth(itemWidthSelector)
    }
    
    func itemWidth(itemWidthSelector: UISegmentedControl) -> CGFloat {
        switch itemWidthSelector.selectedSegmentIndex {
        case 0: return 75
        case 1: return 100
        case 2: return 125
        default: return 75
        }
    }
}

