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
        activityViewController.startLoading()
        XCTAssertEqual(activityViewController.containerView.alpha, 0.0)
        XCTAssertTrue(activityViewController.activityIndicator.isAnimating)
    }
    
    func testStopLoading() {
        activityViewController.stopLoading()
        XCTAssertEqual(activityViewController.containerView.alpha, 1.0)
        XCTAssertFalse(activityViewController.activityIndicator.isAnimating)
    }
    
}
