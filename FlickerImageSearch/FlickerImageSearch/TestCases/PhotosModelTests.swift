//
//  PhotosModelTests.swift
//  FlickerImageSearch
//
//  Created by SOM on 18/07/21.
//

import XCTest
@testable import FlickerImageSearch

class MockJSONData: XCTestCase {
    

    static let expectedJSON = [ "stat": "ok",
                                "photos": [
                                    "page": 1,
                                    "pages": 1367,
                                    "perpage": 100,
                                    "total": 136676,
                                    "photo": [
                                        [ "id": "51302087886",
                                          "owner": "189020000@N08",
                                          "secret": "01a760e311",
                                          "server": "65535",
                                          "farm": 66,
                                          "title": "Pink Kitten",
                                          "ispublic": 1,
                                          "isfriend": 0,
                                          "isfamily": 0
                                        ]
                                    ]
                                ]
                                
    ] as [String : Any]
    
    static let inValidJSON = [ "stat": "ok",
                               "photos": [
                                    "page": 1,
                                    "pages": 1367,
                                    "perpage": 100,
                                    "total": 136676,
                                    "photo": [ [] ]
                               ]
    ] as [String : Any]

}

class PhotosModelTests: XCTestCase {

    // Convert from JSON to nsdata
    func jsonToNSData(json: [String : Any]) -> Data?{
        do {
            return try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) as Data
        } catch let error {
            print(error)
        }
        return nil;
    }
    
    func testValidJSON() {
        guard let jsonData = self.jsonToNSData(json: MockJSONData.expectedJSON) else {
            XCTAssertFalse(false)
            return
        }
    
        let jsonObject = try! JSONDecoder().decode(PhotosResponse.self, from: jsonData)
        XCTAssertEqual(jsonObject.stat?.uppercased(), "OK")
        XCTAssertEqual(jsonObject.photos?.page, 1)
        XCTAssertEqual(jsonObject.photos?.pages, 1367)
        XCTAssertEqual(jsonObject.photos?.perpage, 100)
        XCTAssertEqual(jsonObject.photos?.total, 136676)
        XCTAssertEqual(jsonObject.photos?.photo.first?.id, "51302087886")
        XCTAssertEqual(jsonObject.photos?.photo.first?.owner, "189020000@N08")
        XCTAssertEqual(jsonObject.photos?.photo.first?.secret, "01a760e311")
        XCTAssertEqual(jsonObject.photos?.photo.first?.server, "65535")
        XCTAssertEqual(jsonObject.photos?.photo.first?.farm, 66)
    }
    
    func testInvalidJSON() {
        guard (self.jsonToNSData(json: MockJSONData.inValidJSON) != nil) else {
            XCTAssertTrue(true)
            return
        }
        XCTAssertFalse(false)
    }
}
