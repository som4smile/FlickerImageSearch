//
//  BaseViewController.swift
//  FlickerImageSearch
//
//  Created by SOM on 13/07/21.
//

import UIKit

class BaseViewController: UIViewController {

    private var vSpinner : UIView?

    /**
     Add Spinner View on given view.
     
     - Parameter onView: View on which spinner view is getting added.
    */
    func showSpinner(onView : UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(style: UIActivityIndicatorView.Style.large)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        
        self.vSpinner = spinnerView
    }
    
    /**
     Removes Spinner View from parent view.
    */
    func removeSpinner() {
        DispatchQueue.main.async {
            self.vSpinner?.removeFromSuperview()
            self.vSpinner = nil
        }
    }
    
    /**
     Displays Alert with given title and message o view.

     - Parameters:
        - title: Title of the alert.
        - withMessage: Tmessage of the alert.
    */
    func showAlert(withTitle title: String, withMessage message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(ok)
        
        DispatchQueue.main.async(execute: {
            self.present(alert, animated: true)
        })
    }

}
