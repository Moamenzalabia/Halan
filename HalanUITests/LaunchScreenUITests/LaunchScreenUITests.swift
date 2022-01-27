//
//  LaunchScreenUITests.swift
//  HalanUITests
//
//  Created by Moamen Abd Elgawad on 24/01/2022.
//

import XCTest

class LaunchScreenUITests: XCTestCase {
    
    let application = XCUIApplication()
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = true
        application.launch()
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }
    
    func testLaunchScreen() throws {
        let attachment = XCTAttachment(screenshot: application.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
