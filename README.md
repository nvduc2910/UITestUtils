# UITestUtils

[![CI Status](https://img.shields.io/travis/nvduc2910/UITestUtils.svg?style=flat)](https://travis-ci.org/nvduc2910/UITestUtils)
[![Version](https://img.shields.io/cocoapods/v/UITestUtils.svg?style=flat)](https://cocoapods.org/pods/UITestUtils)
[![License](https://img.shields.io/cocoapods/l/UITestUtils.svg?style=flat)](https://cocoapods.org/pods/UITestUtils)
[![Platform](https://img.shields.io/cocoapods/p/UITestUtils.svg?style=flat)](https://cocoapods.org/pods/UITestUtils)

Utilities support write UI Testing for Swift

## Local HTTP Server

Supporting local server by [Embassy](https://github.com/envoy/Embassy) and [Ambassador](https://github.com/envoy/Ambassador)

```swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let arguments = ProcessInfo.processInfo.arguments
        for argument in arguments {
            switch argument {
            case "UI_TESTING":
                ServicesAPI.shared.configureBaseURL("http://localhost:8080")
            default:
                ServicesAPI.shared.configureBaseURL("https://da31de14-b60e-4249-8921-0dcf5d5796ef.mock.pstmn.io")
            }
        }
        return true
    }
```

```swift
router["/api/v2/users"] = DelayResponse(JSONResponse(handler: { _ -> Any in
    return [
        ["id": "01", "name": "john"],
        ["id": "02", "name": "tom"]
    ]
}))
```

JSONString response support

```swift
router["/api/v2/users"] = DelayResponse(JSONStringResponse(handler: { _ -> Any in
    return """
        {
          "acess_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c"
        }
    """
}))
```
## UITest Utils

Page Object Model Design pattern

```swift
 func testInvalidPassword() {
        
        _ = loginPage
            .enterUsername("nvduc2910")
            .enterPassword("")
            .tapLoginButton()
            .then { _ in
                XCTAssert(loginPage.invalidPasswordAlert.exists)
            }
    }
```

AccessId support

```swift
extension LoginController: UITestablePage {
    
    typealias UIElementType = UIElements.LoginUIElements
    
    func makeViewTestable() {
        self.makeViewTestable(self.usernameTextField, using: .userNameTextField)
        self.makeViewTestable(self.passwordTextField, using: .passwordTextField)
        self.makeViewTestable(self.loginButton, using: .loginButton)
    }
}

```

XCTest Extensions

```swift
open func expectToSee(_ element: XCUIElement,
                     within timeout: TimeInterval = 5,
                     _ file: StaticString = #file,
                     _ line: UInt = #line) {
      if element.exists {
        XCTAssertTrue(true)
      } else {
        XCTAssertTrue(element.waitForExistence(timeout: timeout), file: file, line: line)
      }
 }
```

```swift
open func expectNotToSee(_ element: XCUIElement,
                        within timeout: TimeInterval = 5,
                        _ file: StaticString = #file,
                        _ line: UInt = #line) {
      let date = Date().addingTimeInterval(timeout)
      var result = false
      repeat {
        result = !element.exists
      } while !result && Date().timeIntervalSince1970 < date.timeIntervalSince1970

      XCTAssertTrue(result, file: file, line: line)
}
```

```swift
open func enterText(_ text: String, into element: XCUIElement, _ file: StaticString = #file, _ line: UInt = #line) {
      if !element.hasFocus() {
        element.tap()
      }

      element.typeText(text)

      guard let value = element.value as? String else { return XCTFail(file: file, line: line) }
      XCTAssertEqual(value, text, file: file, line: line)
}
```


## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

- Mock real server and local HTTP Server
- Login flow test
- Book list test

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
