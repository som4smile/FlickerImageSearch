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
    
    static func getSerachURL(searchText: String, pageNo: Int) -> URL? {
        
        let urlString = String(format: searchURL, searchText, pageNo)

        guard let url = URL(string: urlString) else {
            return nil
        }
        
        return url
    }
    
    static func getImageURL(farm: Int, server: String, id: String, secret:String) -> URL? {
        let urlString = String(format: imageURL, farm, server, id, secret)
        
        guard let url = URL(string: urlString) else {
            return nil
        }
        
        return url
    }

}
