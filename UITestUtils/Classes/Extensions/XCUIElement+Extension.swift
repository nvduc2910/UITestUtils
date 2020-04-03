//
//  XCUIElement+Extension.swift
//  UITestUtils
//
//  Created by Duckie N on 4/2/20.
//  Copyright © 2020 Nguyen Van Duc. All rights reserved.
//

import Foundation
import XCTest

public extension XCUIElement {
    
    func hasFocus() -> Bool {
        let hasKeyboardFocus = (self.value(forKey: "hasKeyboardFocus") as? Bool) ?? false
        return hasKeyboardFocus
    }
}
