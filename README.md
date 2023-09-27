# MSSPhoneNumber

![iOS](https://img.shields.io/badge/iOS-13.0-green.svg)
![swift](https://img.shields.io/badge/swift-5.5-red.svg)
![Platforms](https://img.shields.io/badge/Platforms-iOS-yellow.svg)
![License](https://img.shields.io/cocoapods/l/MSSPhoneNumber.svg?style=flat)
[![Version](https://img.shields.io/cocoapods/v/MSSPhoneNumber.svg?style=flat)](https://cocoapods.org/pods/MSSPhoneNumber)

MSSPhoneNumber is a Swift framework designed for international phone number validation with built-in support for selecting country codes.

## Features

- Display a country picker to allow users to select their country.
- Validate phone numbers to check if they are in a valid format.
- Check input text in a text field with respect to specified ranges and text.
- Retrieve country information by providing a country code.

## Installation

### Swift Package Manager

The [Swift Package Manager](https://swift.org/package-manager/) is a tool for automating the distribution of Swift code and is integrated into the `swift` compiler.

To add MSSPhoneNumber as a dependency to your Swift package, follow these steps:

1. In your `Package.swift` file, add the following line to the `dependencies` section:

```swift
dependencies: [
    .package(url: "https://github.com/skaik-mo/MSSPhoneNumber.git", from: "1.0.0")
]
```

2. To install MSSPhoneNumber via Xcode, do the following:
- Go to File -> Add Package Dependency...
- Search for https://github.com/skaik-mo/MSSPhoneNumber.git
- Choose the version you want

### CocoaPods

[CocoaPods](https://cocoapods.org/) is a dependency manager for Cocoa projects. For usage and installation instructions, visit their website. To integrate MSSPhoneNumber into your Xcode project using CocoaPods, specify it in your Podfile:

```ruby
pod 'MSSPhoneNumber'
```

## Usage
Import MSSPhoneNumber at the top of the Swift file that will interact with a phone number.

```swift
import MSSPhoneNumber
```

All interactions with MSSPhoneNumber happen through a MSSPhoneNumber object. To get started, allocate one:

```swift
let mssPhoneNumber = MSSPhoneNumber()
```

### Retrieving Country Information
You can use MSSPhoneNumber to retrieve country information by providing a country code:

```swift
let country: Country? = self.mssPhoneNumber.getCountry(code: "PS")
```

### Show Country Picker
The `showCountryPicker()` function is responsible for displaying a country picker view controller:

```swift
mssPhoneNumber.getSelectedCountry = { country in 
    // Handle the selected country in this completion handler
}
mssPhoneNumber.showCountryPicker()
```
### Validate a Phone Number
The `isValid(fieldTitle:phone:)` function is used to validate a phone number string. It takes two parameters:

`fieldTitle`: A string representing the title of the field being validated (default value is "Phone number").

`phone`: The phone number string to be validated.

```swift
let isValid: Bool = mssPhoneNumber.isValid(fieldTitle: "Phone number", phone: "123456789")
```

### Check Text Input
The `checkTextInput(textField:range:text:)` function is used to check if adding or replacing text in a `UITextField` would result in a valid text based on certain criteria. You can integrate it into your `UITextFieldDelegate` methods:

```swift
extension ViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return mssPhoneNumber.checkRangText(textField: textField, range: range, text: string)
    }
}
```


This function helps ensure that text input adheres to specific criteria, which can be particularly useful for phone number entry.

## Contact
Mohammed Skaik
* Email: mohamedsaeb.skaik@gmail.com
* Linkedin: [skaik-mo](http://www.linkedin.com/in/skaik-mo/)

## License

MSSPhoneNumber is released under the MIT license. [See LICENSE](https://github.com/skaik-mo/MSSPhoneNumber/blob/main/LICENSE) for details.
