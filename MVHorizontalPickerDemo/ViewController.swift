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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        picker.font = UIFont.boldSystemFontOfSize(18)
    
        picker.titles = [ "100MB", "200MB", "500MB", "1GB", "2GB", "5GB" ]
        
        picker.itemWidth = 100

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
}

