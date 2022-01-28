//
//  ActivityViewControllerTests.swift
//  HalanTests
//
//  Created by Moamen Abd Elgawad on 26/01/2022.
//

import XCTest
@testable import Halan

class ActivityViewControllerTests: XCTestCase {
    
    var activityViewController: ActivityViewController!
    var mockDataService: MockActivityDataService!
    
    override func setUp() {
        super.setUp()
        activityViewController = ActivityViewController.instance()
        mockDataService = MockActivityDataService()
        activityViewController.viewModel = ActivityViewModel(service: mockDataService)
        activityViewController?.loadViewIfNeeded()
    }
    
    override func tearDown() {
        activityViewController = nil
        mockDataService = nil
        super.tearDown()
    }
    
    func testViewDidLoad() {
        activityViewController.viewDidLoad()
        XCTAssertNotNil(activityViewController.viewModel)
        XCTAssertTrue(activityViewController.replaceActivityButton.isHidden)
    }
    
    func testConfigureUI() {
        XCTAssertEqual(activityViewController.navigationItem.title, "Activity")
    }
    
    func testFetchActivitySuccessScenario() {
        let expectation = expectation(description: "Fetching Activity Success did finish")
        expectation.assertForOverFulfill = false
        
        activityViewController.initViewModel()
        activityViewController.viewModel?.updateLoadingStatus = {
            if self.activityViewController.viewModel?.contentState == .populated {
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 10)
        
        XCTAssertEqual(activityViewController.viewModel?.contentState, .populated)
        XCTAssertEqual(activityViewController.titleLabel.text, "Visit your past teachers")
        XCTAssertEqual(activityViewController.activityLabel.text, "Visit your past teachers")
        XCTAssertEqual(activityViewController.participantsLabel.text, "\(1)")
        
    }
    
    func testFetchActivityFailureScenario() {
        let expectation = XCTestExpectation(description: "Fetch Activity failure did finish")
        expectation.assertForOverFulfill = false
        
        mockDataService.isTestSuccess = false
        
        activityViewController.initViewModel()
        activityViewController.viewModel?.updateLoadingStatus = {
            if self.activityViewController.viewModel?.contentState == .error {
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 10)
        
        XCTAssertEqual(activityViewController.viewModel?.contentState, .error)
        XCTAssertNotNil(activityViewController.viewModel?.alertMessage)
        
    }
    
    func testStartLoading() {
        activityViewController.viewModel?.loadingType = .ViewLoading
        activityViewController.startLoading()
        
        XCTAssertTrue(activityViewController.containerView.isHidden)
        XCTAssertTrue(activityViewController.activityIndicator.isAnimating)
        
        activityViewController.viewModel?.loadingType = .ButtonLoading
        activityViewController.startLoading()
        
        XCTAssertTrue(activityViewController.replaceActivityButton.isLoading)
    }
    
    func testStopLoading() {
        activityViewController.viewModel?.loadingType = .ViewLoading
        activityViewController.stopLoading()
        
        XCTAssertFalse(activityViewController.containerView.isHidden)
        XCTAssertFalse(activityViewController.activityIndicator.isAnimating)
        
        activityViewController.viewModel?.loadingType = .ButtonLoading
        activityViewController.stopLoading()
        
        XCTAssertFalse(activityViewController.replaceActivityButton.isLoading)
    }
    
    func testSetupAccessibilityIdentifier() {
        XCTAssertEqual(activityViewController.containerView.accessibilityIdentifier, "containerViewIdentifier")
        XCTAssertEqual(activityViewController.activityIndicator.accessibilityIdentifier, "activityIndicatorIdentifier")
        XCTAssertEqual(activityViewController.replaceActivityButton.accessibilityIdentifier, "replaceActivityButtonIdentifier")
    }
    
}
