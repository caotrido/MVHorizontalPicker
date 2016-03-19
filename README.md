# MVHorizontalPicker

MVHorizontalPicker is a simple scrollable horizontal control, alternative to UISegmentedControl.

[![License](https://img.shields.io/badge/license-MIT-blue.svg?style=flat
            )](http://mit-license.org)
[![Platform](http://img.shields.io/badge/platform-ios%20%7C%20osx-lightgrey.svg?style=flat
             )](https://developer.apple.com/resources/)
[![Language](http://img.shields.io/badge/language-swift-orange.svg?style=flat
             )](https://developer.apple.com/swift)
[![Issues](https://img.shields.io/github/issues/bizz84/MVHorizontalPicker.svg?style=flat
           )](https://github.com/bizz84/MVHorizontalPicker/issues)
[![Cocoapod](http://img.shields.io/cocoapods/v/MVHorizontalPicker.svg?style=flat)](http://cocoadocs.org/docsets/MVHorizontalPicker/)

## Preview

![MVHorizontalPicker preview](https://github.com/bizz84/MVHorizontalPicker/raw/master/preview.gif "MVHorizontalPicker preview")

## Motivation

While `UISegmentedControl` is a good way of selecting amongst a few options, generally it has only space to show up to 5 values on iPhone portrait mode.
For larger option sets `UIPickerView` can be the right choice, however it also takes up more screen space.

`MVHorizontalPicker` is the ideal UI control for choosing an item from up to a dozen possible values.

## Preview

## Usage

```swift
class ViewController: UIViewController {

    @IBOutlet var picker: MVHorizontalPicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        picker.titles = [ "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday" ]
    }

    @IBAction func pickerValueChanged(sender: AnyObject) { // Value Changed event

        let title = picker.titles[picker.selectedItemIndex]
        print("selected: \(title)")
    }
}
```

### Customisation

`MVHorizontalPicker` is `IBDesignable`/`IBInspectable` compatible. Supported properties:

* textColor
* font
* itemWidth
* borderColor
* borderWidth
* cornerRadius

## Installation

MVHorizontalPicker can be installed as a Cocoapod and builds as a Swift framework. To install, include this in your Podfile.

```
use_frameworks!

pod 'MVHorizontalPicker'
```
Once installed, just import MVHorizontalPicker in your classes and you're good to go.

## Sample Code

A sample demo target is included to show how to use `MVHorizontalPicker`.


## License

