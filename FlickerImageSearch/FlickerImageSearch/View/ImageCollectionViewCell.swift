//
//  ImageCollectionViewCell.swift
//  FlickerImageSearch
//
//  Created by SOM on 12/07/21.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!

    static let cellIdentifier = "ImageCollectionViewCell"
    
    var photoModel: Photo? {
        didSet{
            
            guard let imageURL = self.photoModel?.imageURLString else { return }

            if let image = ImageCache.shared.getImageFromCache(key: imageURL.absoluteString) {
                
                //already cached
                self.imageView.image = image
            } else {
                
                APIManager.shared.downloadImage(url: imageURL, completion: { result in
                    
                    switch result {
                    case .Success(let image):

                        ImageCache.shared.saveImageToCache(key: imageURL.absoluteString, image: image)
                        DispatchQueue.main.async {
                            self.imageView.image = image
                        }
                        
                    case .Error(let errorMessage):
                        print(errorMessage)
                    }
                    
                })
            }
        }
    }
}
