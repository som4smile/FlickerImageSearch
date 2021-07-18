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
            
            APIManager.shared.downloadImage(url: imageURL, completion: { result in
                
                switch result {
                case .Success(let image):
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
