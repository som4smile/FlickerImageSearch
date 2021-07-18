//
//  APIManagerTests.swift
//  FlickerImageSearch
//
//  Created by SOM on 18/07/21.
//

import XCTest
@testable import FlickerImageSearch

class APIManagerTests: XCTestCase {

    private let searchString = "Kitten"
    private let expect = XCTestExpectation(description:"testing")
    private let pageNo = 1
    
    func testSearchDataSuccess() {
        APIManager.shared.search(searchText: self.searchString, pageNo: self.pageNo, completion: { [weak self] result in
            
            switch result {
            case .Success(let data):
                if let photos = FlickerImageViewModel.shared.parseResponse(data) {
                    XCTAssertEqual(photos.page, 1)
                    XCTAssertEqual(photos.perpage, 20)
                    XCTAssertNotNil(photos.photo)
                } else {
                    XCTFail()
                }
                
            case .Error(let errorMessage):
                print(errorMessage)
                XCTFail()
            }
            
            self?.expect.fulfill()
        })
        wait(for: [self.expect], timeout: 15)
    }

}
