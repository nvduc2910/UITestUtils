//
//  PageObject.swift
//  UITestUtils
//
//  Created by Duckie N on 4/2/20.
//  Copyright © 2020 Nguyen Van Duc. All rights reserved.
//

import Foundation
import XCTest
import Then

open class Page {

    let app: XCUIApplication

    init(app: XCUIApplication) {
        self.app = app
    }
}

extension Page: Then { }
