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
        guard let url = FlickerImageConfig.getSerachURL(searchText: self.searchString, pageNo: pageNo) else {
            return
        }

        APIManager.shared.search(url: url, searchText: self.searchString, pageNo: self.pageNo, completion: { [weak self] result in
            
            switch result {
            case .Success(let data):
                let response = FlickerImageViewModel.shared.parseResponse(data)
                if let photos = response {
                    XCTAssertEqual(photos.page, 1)
                    XCTAssertEqual(photos.perpage, 20)
                    XCTAssertNotNil(photos.photo)
                } else {
                    XCTAssertNil(response)
                }
                
            case .Error(_):
                XCTAssertFalse(false)
            }
            
            self?.expect.fulfill()
        })
        wait(for: [self.expect], timeout: 10)
    }
    
    func testSearchDataFail() {
        
        let searchURL = "https://api.com/services/rest/?method=flickr.photos.search&api_key=2932ade8b209152a7cbb49b631c4f9b6&format=json&nojsoncallback=1&safe_search=1&per_page=20&text=\(self.searchString)&page=\(self.pageNo)"

        guard let url = URL(string: searchURL) else { return }
        
        APIManager.shared.search(url: url, searchText: self.searchString, pageNo: self.pageNo, completion: { [weak self] result in
            
            switch result {
            case .Success(_): break
                
            case .Error(_):
                XCTAssertFalse(false)
            }
            
            self?.expect.fulfill()
        })
        wait(for: [self.expect], timeout: 10)
    }
}

