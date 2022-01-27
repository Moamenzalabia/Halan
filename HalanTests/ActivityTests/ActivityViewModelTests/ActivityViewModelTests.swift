//
//  ActivityViewModelTests.swift
//  HalanTests
//
//  Created by Moamen Abd Elgawad on 26/01/2022.
//

import XCTest
@testable import Halan

class ActivityViewModelTests: XCTestCase {
    
    var viewModel: ActivityViewModel!
    var mockDataService:MockActivityDataService!
    
    override func setUp() {
        super.setUp()
        mockDataService = MockActivityDataService()
        viewModel = ActivityViewModel(service: mockDataService)
    }
    
    override func tearDown() {
        viewModel = nil
        mockDataService = nil
        super.tearDown()
    }
    
    func testFetchActivitySuccess() {
        let expectation = expectation(description: "Fetching Activity Success did finish")
        expectation.assertForOverFulfill = false
        
        viewModel.fetchActivity()
        viewModel.updateLoadingStatus = {
            if self.viewModel.contentState == .populated {
                expectation.fulfill()
            }
        }
        
        XCTAssertEqual(viewModel.contentState, .loading)
        
        wait(for: [expectation], timeout: 10)
        
        XCTAssertEqual(viewModel.contentState, .populated)
        XCTAssertNotNil(viewModel.activityUIData)
        XCTAssertNil(viewModel.alertMessage)
    }
    
    func testFetchActivityFailure() {
        let expectation = XCTestExpectation(description: "Fetch Activity failure did finish")
        expectation.assertForOverFulfill = false
        
        mockDataService.isTestSuccess = false
        
        viewModel.fetchActivity()
        viewModel.updateLoadingStatus = {
            if self.viewModel.contentState == .error {
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 10)
        
        XCTAssertEqual(viewModel.contentState, .error)
        XCTAssertNotNil(viewModel.alertMessage)
        XCTAssertNil(viewModel.activityUIData)
    }
}
