//
//  Extensions.swift
//  BankTest
//
//  Created by Yu-Chih Shen on 2024/5/25.
//

import UIKit

extension UIFont {
    class var textStyle3: UIFont {
        return UIFont.systemFont(ofSize: 24.0, weight: .medium)
    }
    class var textStyle10: UIFont {
        return UIFont.systemFont(ofSize: 18.0, weight: .heavy)
    }
    class var textStyle5: UIFont {
        return UIFont.systemFont(ofSize: 18.0, weight: .bold)
    }
    class var textStyle: UIFont {
        return UIFont.systemFont(ofSize: 18.0, weight: .medium)
    }
    class var textStyle2: UIFont {
        return UIFont.systemFont(ofSize: 16.0, weight: .regular)
    }
    class var textStyle6: UIFont {
        return UIFont.systemFont(ofSize: 14.0, weight: .regular)
    }
    class var textStyle4: UIFont {
        return UIFont.systemFont(ofSize: 14.0, weight: .regular)
    }
    class var textStyle8: UIFont {
        return UIFont.systemFont(ofSize: 12.0, weight: .semibold)
    }
}

extension UIView {
    func showSkeleton() {
        let backgroundColor = UIColor(named: "white - Zero")!.cgColor
        let highlightColor = UIColor(named: "white - Three")!.cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [highlightColor, backgroundColor, highlightColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradientLayer.locations = [0.0, 0.5, 1.0]
        gradientLayer.frame = self.bounds

        self.layer.addSublayer(gradientLayer)
        
        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = [-1.0, -0.5, 0.0]
        animation.toValue = [1.0, 1.5, 2.0]
        animation.repeatCount = .infinity
        animation.duration = 1
        gradientLayer.add(animation, forKey: animation.keyPath)
    }
}

