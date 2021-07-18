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
    
    func testSearchData() {
        APIManager.shared.search(searchText: self.searchString, pageNo: self.pageNo, completion: { [weak self] result in
            
            switch result {
            case .Success( _):
                break
                
            case .Error( _):
                break
            
            }
            
            self?.expect.fulfill()
        })
        wait(for: [self.expect], timeout: 5)
    }

}
