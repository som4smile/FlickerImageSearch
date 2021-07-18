//
//  Photos.swift
//  FlickerImageSearch
//
//  Created by SOM on 12/07/21.
//

import UIKit


struct PhotosResponse: Decodable {
    let stat: String?
    let photos: Photos?
}

struct Photos: Decodable {
    let page: Int
    let pages: Int
    let perpage: Int
    let total: Int
    let photo: [Photo]
}

struct Photo: Decodable {
    let id : String
    let owner: String
    let secret : String
    let server : String
    let farm : Int
    let title: String
    let ispublic : Int
    let isfriend : Int
    let isfamily : Int
    
    var imageURLString: URL? {
        return FlickerImageConfig.getImageURL(farm: self.farm,
                                              server: self.server,
                                              id: self.id,
                                              secret: self.secret)
    }
}
