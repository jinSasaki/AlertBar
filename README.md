# AlertBar

[![Version](https://img.shields.io/cocoapods/v/AlertBar.svg?style=flat)](http://cocoapods.org/pods/AlertBar)
[![License](https://img.shields.io/cocoapods/l/AlertBar.svg?style=flat)](http://cocoapods.org/pods/AlertBar)
[![Platform](https://img.shields.io/cocoapods/p/AlertBar.svg?style=flat)](http://cocoapods.org/pods/AlertBar)

An easy alert on status bar.

![demo](./etc/demo.gif)

## Usage
### Import
```
import AlertBar
```

### Show alert message
#### Success
```
AlertBar.show(.Success, message: "This is a Success message.")
```

#### Error
```
AlertBar.show(.Error, message: "This is an Error message.")
```

#### Notice
```
AlertBar.show(.Notice, message: "This is a Notice message.")
```

#### Warning
```
AlertBar.show(.Warning, message: "This is a Warning message.")
```

#### Info
```
AlertBar.show(.Info, message: "This is an Info message.")
```

#### Custom
```
AlertBar.show(.Custom(UIColor.lightGrayColor(), UIColor.blackColor()), message: "This is a Custom message.")
```

### Custom alert duration
```
AlertBar.show(.Success, message: "This is a Success message.", duration: 10)
```

## Requirements

- Swift 2.0
- iOS 8.0
- ARC

## Installation

AlertBar is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "AlertBar"
```

## Author

Jin Sasaki, sasakky_j@gmail.com

## License

AlertBar is available under the MIT license. See the LICENSE file for more info.
