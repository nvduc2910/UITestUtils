# UITestUtils

[![CI Status](https://img.shields.io/travis/nvduc2910/UITestUtils.svg?style=flat)](https://travis-ci.org/nvduc2910/UITestUtils)
[![Version](https://img.shields.io/cocoapods/v/UITestUtils.svg?style=flat)](https://cocoapods.org/pods/UITestUtils)
[![License](https://img.shields.io/cocoapods/l/UITestUtils.svg?style=flat)](https://cocoapods.org/pods/UITestUtils)
[![Platform](https://img.shields.io/cocoapods/p/UITestUtils.svg?style=flat)](https://cocoapods.org/pods/UITestUtils)

Utility support write UI Testing for Swift

## Local HTTP Server

Supporting local server by [Embassy](https://github.com/envoy/Embassy) and [Ambassador](https://github.com/envoy/Ambassador)

```
router["/api/v2/users"] = DelayResponse(JSONResponse(handler: { _ -> Any in
    return [
        ["id": "01", "name": "john"],
        ["id": "02", "name": "tom"]
    ]
}))
```

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

UITestUtils is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'UITestUtils'
```

## Author

nvduc2910, v.ducnv29@vinid.net

## License

UITestUtils is available under the MIT license. See the LICENSE file for more info.
