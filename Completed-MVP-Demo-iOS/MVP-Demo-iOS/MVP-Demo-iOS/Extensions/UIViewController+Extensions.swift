//
//  SpinnerView.swift
//  MVP-Demo-iOS
//
//  Created by Ikmal Azman on 24/12/2021.
//

import UIKit

private var spinnerView : UIView?

extension UIViewController {
    
    func addSpinner() {
        spinnerView = UIView(frame: view.bounds)
        guard let spinnerView = spinnerView else {
            return
        }
        spinnerView.backgroundColor = .lightGray
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.center = view.center
        activityIndicator.startAnimating()
        spinnerView.addSubview(activityIndicator)
        view.addSubview(spinnerView)
    }
    
    func removeSpinner() {
        guard let spinnerView = spinnerView else {
            return
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            spinnerView.removeFromSuperview()
        }
    }
}
