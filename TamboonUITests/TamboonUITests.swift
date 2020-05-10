//
//  TamboonUITests.swift
//  TamboonUITests
//
//  Created by Miroslav Djukic on 10/05/2020.
//  Copyright © 2020 Miroslav Djukic. All rights reserved.
//

import XCTest


class TamboonUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCharityListTap() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        let charityIsLoaded = app.buttons["test name"].exists
        XCTAssertTrue(charityIsLoaded)
    }
    
    func testDonationViewNavigation() throws {
        let app = XCUIApplication()
        app.launch()
        let openDonationButton = app.buttons["test name"]
        openDonationButton.tap()
        
        let cardLabelLoaded = app.scrollViews.staticTexts["Card number"].exists
        XCTAssert(cardLabelLoaded)
    }
    
    func testAmountPinPad() throws {
        let app = XCUIApplication()
        app.launch()
        let openDonationButton = app.buttons["test name"]
        openDonationButton.tap()
        
        let buttonOne = app.scrollViews.buttons["1"]
        let buttonTwo = app.scrollViews.buttons["2"]
        
        XCTAssertFalse(buttonOne.isHittable)
        
        let amountButton = app.scrollViews.buttons["฿0"]
        amountButton.tap()
        
        
        XCTAssertTrue(buttonOne.isHittable)
        
        buttonOne.tap()
        buttonTwo.tap()
        
        
        let amountButtonTextUpdatedProperly = app.scrollViews.buttons["฿12"].exists
        
        
        XCTAssert(amountButtonTextUpdatedProperly)
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
