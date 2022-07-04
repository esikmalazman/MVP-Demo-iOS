//
//  SpinnerView.swift
//  MVP-Demo-iOS
//
//  Created by Ikmal Azman on 24/12/2021.
//

import UIKit

 private(set) var spinnerView : UIView?

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
        /// Make the dispatch weak to remove retain cycle in VC and make test pass
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            spinnerView?.removeFromSuperview()
            spinnerView = nil
        }
    }
    
    /// Wrapper method to determine if work already in Main Thread active immediately otherwise ask it to run on main queue.
    /// When in production task run in bg task it will dispatch into Main Queue, allow the test to pass since it run in Main Thread.
    /// - https://www.youtube.com/watch?v=jH7Zfi7TQt8
    func guaranteeMainThread(_ work : @escaping ()-> Void) {
        if Thread.isMainThread {
            work()
        } else {
            DispatchQueue.main.async(execute: work)
        }
    }
}
