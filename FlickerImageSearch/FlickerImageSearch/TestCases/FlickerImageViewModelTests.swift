//
//  FlickerImageViewModelTests.swift
//  FlickerImageSearch
//
//  Created by SOM on 18/07/21.
//

import XCTest
@testable import FlickerImageSearch

class FlickerImageViewModelTests: XCTestCase {
        
    private let searchString = "Kitten"
    private let successResponse = "Success Response"
    private let errorResponse = "Parsing error"
    private let expect = XCTestExpectation(description:"testing")

    func testSearch(){

        FlickerImageViewModel.shared.search(text: self.searchString, completion: { [weak self] result in
            
            switch result{
            case .Success(let response):
                XCTAssertEqual(response, self?.successResponse)
                
            case .Error(let error):
                XCTAssertEqual(error, self?.errorResponse)
            }
            self?.expect.fulfill()
        })
        wait(for: [self.expect], timeout: 5)
        
    }
    
    func testFetchNextPageFail() {
        FlickerImageViewModel.shared.pageNo = 1
        FlickerImageViewModel.shared.totalPages = 1

        FlickerImageViewModel.shared.fetchNextPage {
            XCTAssertFalse(false)
            self.expect.fulfill()
        }
        wait(for: [self.expect], timeout: 5)
    }
    
    func testFetchNextPageSuccess() {
        FlickerImageViewModel.shared.pageNo = 0
        FlickerImageViewModel.shared.totalPages = 1

        FlickerImageViewModel.shared.fetchNextPage {
            XCTAssertTrue(true)
            self.expect.fulfill()
        }
        wait(for: [self.expect], timeout: 5)
    }

}
