//
//  ActivityViewControllerUITests.swift
//  HalanUITests
//
//  Created by Moamen Abd Elgawad on 24/01/2022.
//

import XCTest

class ActivityViewControllerUITests: XCTestCase {
    
    let application = XCUIApplication()
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = true
        application.launch()
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    func testReplaceActivityButton() {
        // UI tests must launch the application that they test.
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let replaceActivityButton = application.buttons["replaceActivityButtonIdentifier"]
        XCTAssertFalse(replaceActivityButton.waitForExistence(timeout: 8), "can't found replace Activity Button")
        openActivityViewController()
        XCTAssertTrue(replaceActivityButton.waitForExistence(timeout: 8), "can't found replace Activity Button")
        
        replaceActivityButton.tap()
        
        let containerView = application.otherElements["containerViewIdentifier"]
        
        XCTAssertTrue(containerView.waitForExistence(timeout: 8), "can't found activity container view")
    }
    
    func testLoading() {
        let activityIndicator = application.otherElements["activityIndicatorIdentifier"]
        let containerView = application.otherElements["containerViewIdentifier"]
        
        openActivityViewController()
        
        XCTAssertTrue(containerView.waitForExistence(timeout: 8), "can't found activity container view")
        XCTAssertFalse(activityIndicator.waitForExistence(timeout: 8), "can't found activity indicator")
    }
    
}

extension ActivityViewControllerUITests {
    func openActivityViewController() {
        let startButton = application.buttons["startButtonIdentifier"]
        XCTAssert(startButton.exists)
        startButton.tap()
    }
}
