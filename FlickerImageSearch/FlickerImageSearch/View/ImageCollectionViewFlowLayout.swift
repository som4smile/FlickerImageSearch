//
//  ImageCollectionViewFlowLayout.swift
//  FlickerImageSearch
//
//  Created by SOM on 12/07/21.
//

import UIKit

extension PhotosViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionWidth = self.imageCollectionView.bounds.width
        return CGSize(width: collectionWidth/3-1, height: collectionWidth/3-1)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
  
    
}
