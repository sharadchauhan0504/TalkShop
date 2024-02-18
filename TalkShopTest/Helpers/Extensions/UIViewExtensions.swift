//
//  UIViewExtensions.swift
//  TalkShopTest
//
//  Created by Sharad Chauhan on 16/02/24.
//

import UIKit

extension UIView {
    
    func cornerRadius(_ radius: CGFloat) {
        layer.cornerRadius = radius
        layer.masksToBounds = true
        layer.cornerCurve = .continuous
    }
    
    func border(_ width: CGFloat, _ color: UIColor) {
        layer.borderColor = color.cgColor
        layer.borderWidth = width
    }
    
    func fadeIn(_ time: TimeInterval = 0.2) {
        alpha = 0.0
        UIView.animate(withDuration: time, delay: 0.0, options: .curveEaseInOut) {
            self.alpha = 1.0
        } completion: { isSuccess in
            
        }
    }
    
    func fadeOut(_ time: TimeInterval = 0.2, _ completion: (() -> Void)? = nil) {
        alpha = 1.0
        UIView.animate(withDuration: time, delay: 0.0, options: .curveEaseInOut) {
            self.alpha = 0.0
        } completion: { isSuccess in
            completion?()
        }
    }
    
    func bounce(_ completion: (() -> Void)?) {
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseInOut) {
            self.transform = CGAffineTransform(scaleX: 0.98, y: 0.98)
        } completion: { isSuccess in
            UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseInOut) {
                self.transform = .identity
            } completion: { isSuccess in
                completion?()
            }
        }
    }
    
    func addGradient(_ colors: [CGColor], _ locations: [NSNumber]) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors
        gradientLayer.locations = locations
        gradientLayer.frame = bounds
        layer.insertSublayer(gradientLayer, at:0)
    }
}
