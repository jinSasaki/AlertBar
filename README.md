# AlertBar

[![Version](https://img.shields.io/cocoapods/v/AlertBar.svg?style=flat)](http://cocoapods.org/pods/AlertBar)
[![License](https://img.shields.io/cocoapods/l/AlertBar.svg?style=flat)](http://cocoapods.org/pods/AlertBar)
[![Platform](https://img.shields.io/cocoapods/p/AlertBar.svg?style=flat)](http://cocoapods.org/pods/AlertBar)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

An easy alert on status bar.

| Demo |
| :---: |
| ![demo](./assets/demo.gif) |

## Usage
### Import
```swift
import AlertBar
```

### Show alert message
AlertBar has default types:
- success
- error
- notice
- warning
- info

```swift
AlertBar.show(type: .success, message: "This is a Success message.")
```

And you can customize the background and text colors of AlertBar.  
Select `custom` type and set background and text colors as UIColor:  `.custom(BackgroundColor, TextColor)`

```swift
AlertBar.show(type: .custom(.lightGray, .black), message: "This is a Custom message.")
```

#### Alert duration
AlertBar accepts to custom alert duration.
```swift
AlertBar.show(type: .success, message: "This is a Success message.", duration: 10)
```

### AlertBar Options

AlertBar accepts options follows:

- Consider Safe Area
- Stretch bar
- TextAlignment

Use `setDefault` method to set default options.
```swift
let options = AlertBar.Options(
    shouldConsiderSafeArea: true, 
    isStretchable: true, 
    textAlignment: .center,
    font: UIFont.systemFont(ofSize: 14.0, weight: .medium)
)
AlertBar.setDefault(options: options)
```

Or set parameter of `show` method to each AlertBar.
```swift
let options = AlertBar.Options(
    shouldConsiderSafeArea: true, 
    isStretchable: true, 
    textAlignment: .center,
    font: UIFont.systemFont(ofSize: 14.0, weight: .medium)
)
AlertBar.show(type: .success, message: "This is AlertBar!", options: options)
```

### Consider Safe Area
The Safe Area is adopted from iOS 11 and AlertBar can change whether to consider SafeArea or not.

`AlertBar.Options#shouldConsiderSafeArea: Bool`
is set to `true` by default.

| `shouldConsiderSafeArea == true` | `shouldConsiderSafeArea == false` |
| :---: | :---: |
| ![true](./assets/shouldConsiderSafeArea_true.png) | ![false](./assets/shouldConsiderSafeArea_false.png) |

### Stretch bar
AlertBar can stretch the bar if the message needs the multi lines.

`AlertBar.Options#isStretchable: Bool`
is set to `false` by default.

| `isStretchable == true` | `isStretchable == false` |
| :---: | :---: |
| ![true](./assets/isStretchable_true.png) | ![false](./assets/isStretchable_false.png) |


#### TextAlignment
AlertBar accepts to custom text alignment.

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
