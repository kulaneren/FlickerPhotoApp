//
//  UIViewController+Extensions.swift
//  FlickrApp
//
//  Created by eren  on 31/10/2023.
//

import UIKit

extension UIViewController {

    static var storyboardIdentifier: String {
        return String(describing: self)
    }

    func showLoading(_ withYPoint: CGFloat? = nil) {
        if self.view.viewWithTag(100) != nil {
            return
        }
        let spinnerView = UIView(frame: view.frame)
        spinnerView.backgroundColor = UIColor.theme.warmGrey0_7Alpha

        let imageView = UIImageView()
        imageView.frame = CGRect(x: (spinnerView.frame.width - 30) / 2, y: (spinnerView.frame.height - 30) / 2, width: 30, height: 30)

        if let withYPoint = withYPoint {
            spinnerView.frame.origin.y = withYPoint
            spinnerView.frame.size.height = view.frame.height - withYPoint
            spinnerView.backgroundColor = UIColor.theme.warmGrey0_7Alpha
            imageView.frame = CGRect(x: (spinnerView.frame.width - 30) / 2, y: (spinnerView.frame.height - 30) / 2, width: 30, height: 30)
        }

        view.addSubview(spinnerView)
        spinnerView.addSubview(imageView)
        spinnerView.tag = 100
        imageView.image = UIImage(systemName: "square.circle")

        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = CGFloat(Double.pi * 2)
        rotateAnimation.isRemovedOnCompletion = false
        rotateAnimation.duration = 2
        rotateAnimation.repeatCount=Float.infinity
        imageView.layer.add(rotateAnimation, forKey: nil)
    }

    func hideLoading() {
        if let viewWithTag = self.view.viewWithTag(100) {
            viewWithTag.removeFromSuperview()
        }
    }

    func showInfo(message: String) {
        let alertAction = UIAlertAction(title: "Ok",
                                        style: .default,
                                        handler: nil)
        let alertController = UIAlertController(title:"Info", message: message, preferredStyle: .alert)
        alertController.addAction(alertAction)
        alertController.view.tintColor = UIColor.theme.accent
        present(alertController, animated: true, completion: nil)
    }

    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
