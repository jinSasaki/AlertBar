# AlertBar

[![Version](https://img.shields.io/cocoapods/v/AlertBar.svg?style=flat)](http://cocoapods.org/pods/AlertBar)
[![License](https://img.shields.io/cocoapods/l/AlertBar.svg?style=flat)](http://cocoapods.org/pods/AlertBar)
[![Platform](https://img.shields.io/cocoapods/p/AlertBar.svg?style=flat)](http://cocoapods.org/pods/AlertBar)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

An easy alert on status bar.

![demo](./assets/demo.gif)

## Usage
### Import
```
import AlertBar
```

### Show alert message
AlertBar has default types:
- success
- error
- notice
- warning
- info

```
AlertBar.show(.success, message: "This is a Success message.")
```

And you can customize the background and text colors of AlertBar.  
Select `Custom` type and set background and text colors as UIColor:  `.Custom(BackgroundColor, TextColor)`

```
AlertBar.show(.custom(.lightGray, .black), message: "This is a Custom message.")
```

#### Alert duration
AlertBar accepts to custom alert duration.
```
AlertBar.show(.success, message: "This is a Success message.", duration: 10)
```

### Custom Options
#### TextAlignment
AlertBar accepts to custom text alignment.  
NOTE: This option is global.
```
AlertBar.textAlignment = .center
```

## Requirements

- Swift 3.x
- iOS 8.0+
- ARC

## Installation
### CocoaPods

AlertBar is available through [CocoaPods](http://cocoapods.org).
To install it, simply add the following line to your Podfile:

```ruby
pod "AlertBar"
```

### Carthage

AlertBar is available through [Carthage](https://github.com/Carthage/Carthage) since `0.3.1`.
To install it, simply add the following line to your Cartfile:

```
github "jinSasaki/AlertBar"
```

## Author

Jin Sasaki, sasakky_j@gmail.com

## License

AlertBar is available under the MIT license. See the LICENSE file for more info.
