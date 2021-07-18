//
//  FlickerImageViewModel.swift
//  FlickerImageSearch
//
//  Created by SOM on 12/07/21.
//

import UIKit

protocol DataService {
    func search(text: String, completion: @escaping (Result<String>) -> Void)
}

class FlickerImageViewModel: DataService {
    
    static let shared = FlickerImageViewModel()
    
    private(set) var photosArray = [Photo]()
    private var searchText = ""
    private let successResponse = "Success Response"
    private let parsingError = "Parsing error"
    private let errorMessage = "Some error occured. Please try again later."

    var pageNo = 1
    var totalPages = 1

    /**
     Method to search images.
     - Parameters
      - text: text to be search.
      - completion: completion handler

     - Returns recievedResponse: Pass the recieved response to the clouser with success or failure.
     */
    func search(text: String, completion: @escaping (Result<String>) -> Void) {
        self.photosArray.removeAll()
        self.searchText = text
        fetchResults(completion: completion)
    }
    
    /**
     Method to search images.
     - Parameters
      - completion: completion handler

     - Returns recievedResponse: Pass the recieved response to the clouser with success or failure.
     */
    private func fetchResults(completion:@escaping (Result<String>) -> Void) {

        guard let url = FlickerImageConfig.getSerachURL(searchText: searchText, pageNo: pageNo) else {
            completion(.Error(self.errorMessage))
            return
        }
        
        APIManager.shared.search(url: url, searchText: self.searchText, pageNo: self.pageNo, completion: { result in
            
            switch result {
            case .Success(let data):
                
                if let photos = self.parseResponse(data) {
                    self.totalPages = photos.pages
                    self.photosArray.append(contentsOf: photos.photo)
                    completion(.Success(self.successResponse))
                } else {
                    completion(.Error(self.parsingError))
                }
                
            case .Error(let errorMessage):
                completion(.Error(errorMessage))

            }
        })
    }

    /**
     Method to update the pageNo value for every eteration of Search API request.
     - Parameters
      - completion: completion handler

     - Returns recievedResponse: Pass the recieved response to the clouser with success or failure.
     */
    func fetchNextPage(completion:@escaping () -> Void) {
        if self.pageNo < self.totalPages {
            self.pageNo += 1
            self.fetchResults {_ in
                completion()
            }
        } else {
            completion()
        }
    }

    /**
     Method to parse the received response and decode it in Model class.
     - Parameters
      - data: received response in form of data

     - Returns Photos: decoded response in form of Photos Model class.
     */
    func parseResponse(_ data: Data?) -> Photos? {
        guard let responseData = data,
              let photosResponse = try? JSONDecoder().decode(PhotosResponse.self, from: responseData),
              let status = photosResponse.stat,
              status.uppercased().contains("OK"),
              let photos = photosResponse.photos else {
            return nil
        }
        
        return photos
    }
}
