//
//  UIElement.swift
//  UITestUtils
//
//  Created by Duckie N on 4/2/20.
//  Copyright © 2020 Nguyen Van Duc. All rights reserved.
//

import Foundation
import UIKit
import XCTest

public enum UIElements { }

public protocol UIElement {
    
    var accessibilityIdentifier: String { get }
}

public extension UIElement where Self: RawRepresentable {
    
    var accessibilityIdentifier: RawValue {
        return self.rawValue
    }
}

public protocol UITestablePage {
    
    associatedtype UIElementType: UIElement

    func makeViewTestable(_ view: UIView, using element: UIElementType)
}

public extension UITestablePage {
    
    func makeViewTestable(_ view: UIView, using element: UIElementType) {
        view.accessibilityIdentifier = element.accessibilityIdentifier
    }
}

open class UIElementPage<T: UIElement>: Page {
    
    public override init(app: XCUIApplication) {
        super.init(app: app)
    }
    
    public func label(_ element: T) -> XCUIElement {
        return self.app.staticTexts[element.accessibilityIdentifier]
    }
    
    public func textField(_ element: T) -> XCUIElement {
        return self.app.textFields[element.accessibilityIdentifier]
    }
    
    public func textView(_ element: T) -> XCUIElement {
        return self.app.textViews[element.accessibilityIdentifier]
    }
    
    public func staticText(_ element: T) -> XCUIElement {
        return self.app.staticTexts[element.accessibilityIdentifier]
    }
    
    public func button(_ element: T) -> XCUIElement {
        return self.app.buttons[element.accessibilityIdentifier]
    }
    
    public func image(_ element: T) -> XCUIElement {
        return self.app.images[element.accessibilityIdentifier]
    }
    
    public func table(_ element: T) -> XCUIElement {
        return self.app.tables[element.accessibilityIdentifier]
    }
    
    public func collection(_ element: T) -> XCUIElement {
        return self.app.collectionViews[element.accessibilityIdentifier]
    }
    
    public func alert(_ element: T) -> XCUIElement {
        return self.app.alerts.element.staticTexts[element.accessibilityIdentifier]
    }
    
    public func otherElement(_ element: T) -> XCUIElement {
        return self.app.otherElements[element.accessibilityIdentifier]
    }
    
    open func enterText(_ text: String, into element: XCUIElement, _ file: StaticString = #file, _ line: UInt = #line) {
      if !element.hasFocus() {
        element.tap()
      }

      element.typeText(text)

      guard let value = element.value as? String else { return XCTFail(file: file, line: line) }
      XCTAssertEqual(value, text, file: file, line: line)
    }
}
