//
//  APIManager.swift
//  FlickerImageSearch
//
//  Created by SOM on 12/07/21.
//

import UIKit

enum Result <T>{
    case Success(T)
    case Error(String)
}

class APIManager: NSObject {
    
    static let shared = APIManager()
    private let internetConnectionErrorMessage = "Please check your Internet connection."
    private let errorMessage = "Some error occured. Please try again later."

    func search(url: URL, searchText: String, pageNo: Int, completion: @escaping (Result<Data>) -> Void) {
        
        guard Reachability.currentReachabilityStatus != .notReachable else {
            return completion(.Error(self.internetConnectionErrorMessage))
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard error == nil,
                  let data = data else {
                return completion(.Error(error?.localizedDescription ?? self.errorMessage))
            }
    
            return completion(.Success(data))
            
        }.resume()
    }
    
    func downloadImage(url: URL, completion: @escaping (Result<UIImage>) -> Void) {
        
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
        
        guard Reachability.currentReachabilityStatus != .notReachable else {
            return completion(.Error(self.internetConnectionErrorMessage))
        }

        session.downloadTask(with: url) { (url, reponse, error) in
            do {
                
                guard let url = url else {
                    return completion(.Error(error?.localizedDescription ?? self.errorMessage))
                }
                
                let data = try Data(contentsOf: url)
                if let image = UIImage(data: data) {
                    return completion(.Success(image))
                } else {
                    return completion(.Error(error?.localizedDescription ?? self.errorMessage))
                }
            } catch {
                return completion(.Error(self.errorMessage))
            }
        }.resume()
    }

}
