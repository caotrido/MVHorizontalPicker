# MVHorizontalPicker

MVHorizontalPicker is a simple scrollable horizontal control, alternative to UISegmentedControl.

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

