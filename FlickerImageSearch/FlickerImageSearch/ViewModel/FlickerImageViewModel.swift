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
    private let errorResponse = "Parsing error"
    var pageNo = 1
    var totalPages = 1

    func search(text: String, completion: @escaping (Result<String>) -> Void) {
        self.photosArray.removeAll()
        self.searchText = text
        fetchResults(completion: completion)
    }
    
    private func fetchResults(completion:@escaping (Result<String>) -> Void) {


        APIManager.shared.search(searchText: self.searchText, pageNo: self.pageNo, completion: { result in
            
            switch result {
            case .Success(let data):
                
                if let photos = self.parseResponse(data) {
                    self.totalPages = photos.pages
                    self.photosArray.append(contentsOf: photos.photo)
                    completion(.Success(self.successResponse))
                } else {
                    completion(.Error(self.errorResponse))
                }
                

            case .Error(let errorMessage):
                completion(.Error(errorMessage))

            }
        })
    }

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
