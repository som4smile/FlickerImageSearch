//
//  FlickerImageConfig.swift
//  FlickerImageSearch
//
//  Created by SOM on 12/07/21.
//

import Foundation

class FlickerImageConfig: NSObject {
    
    private static let apiKey = "2932ade8b209152a7cbb49b631c4f9b6"
    private static let perPage = 20
    
    private static let searchURL = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(apiKey)&format=json&nojsoncallback=1&safe_search=1&per_page=\(perPage)&text=%@&page=%ld"
    
    private static let imageURL = "https://farm%d.staticflickr.com/%@/%@_%@.jpg"
    
    /**
     Method to provide URL to search images.
     - Parameters
      - searchText: text to be search.
      - pageNo: page no for maintianing pagination.
     
     - Returns url: Generate URL using API key and other parameters.
     */
    static func getSerachURL(searchText: String, pageNo: Int) -> URL? {
        
        let urlString = String(format: searchURL, searchText, pageNo)

        guard let url = URL(string: urlString) else {
            return nil
        }
        
        return url
    }
    
    /**
     Method to provide URL to download images.
     - Parameters
      - farm: value recieved in search API and needs to pass in image downloading API url.
      - server: value recieved in search API and needs to pass in image downloading API url.
      - id: value recieved in search API and needs to pass in image downloading API url.
      - secret: value recieved in search API and needs to pass in image downloading API url.

     - Returns url: Generate URL using to download the images.
     */
    static func getImageURL(farm: Int, server: String, id: String, secret:String) -> URL? {
        let urlString = String(format: imageURL, farm, server, id, secret)
        
        guard let url = URL(string: urlString) else {
            return nil
        }
        
        return url
    }

}
