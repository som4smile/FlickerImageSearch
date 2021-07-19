//
//  PhotosViewController.swift
//  FlickerImageSearch
//
//  Created by SOM on 10/07/21.
//

import UIKit

class PhotosViewController: BaseViewController {

    @IBOutlet weak var imageSearchBar: UISearchBar!
    @IBOutlet weak var imageCollectionView: UICollectionView!

    private var photosViewModel = FlickerImageViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.imageSearchBar.becomeFirstResponder()
        guard let flowLayout = self.imageCollectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        flowLayout.scrollDirection = .vertical
    }
}

extension PhotosViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.photosViewModel.photosArray.count
    }
    
    internal func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.cellIdentifier, for: indexPath) as? ImageCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.photoModel = self.photosViewModel.photosArray[indexPath.row]
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {

        if indexPath.row == (self.photosViewModel.photosArray.count - 1) {
            self.photosViewModel.fetchNextPage(completion: {
                DispatchQueue.main.async {
                    self.imageCollectionView.reloadData()
                }
            })
        }
    }

}

extension PhotosViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        searchBar.resignFirstResponder()
        
        guard let text = searchBar.text, text.count > 1 else {
            self.showAlert(withTitle: "Please enter some text to search..!!", withMessage: "")
            return
        }
        
        self.showSpinner(onView: self.view)
        self.photosViewModel.search(text: text, completion: { [weak self] result in
            
            self?.removeSpinner()
            
            switch result {
            case .Success(let successMessage):
                print(successMessage)
                DispatchQueue.main.async {
                    self?.imageCollectionView.reloadData()
                }

            case .Error(let errorMessage):
                print(errorMessage)
                self?.showAlert(withTitle: "Error", withMessage: errorMessage)

            }
        })
    }
    
}
