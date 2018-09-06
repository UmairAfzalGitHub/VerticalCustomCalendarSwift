//
//  UIView+.swift
//  
//
//  Created by iMac Limited on 27/05/18.
//  Copyright © 2018 Umair Afzal. All rights reserved.
//

import UIKit

extension UIView {

    func addGradient(_ startPoint: CGPoint, endPoint: CGPoint, startColor:CGColor, endColor: CGColor) {

        let gradient: CAGradientLayer = CAGradientLayer()

        gradient.frame = bounds
        gradient.startPoint = startPoint // CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = endPoint // CGPoint(x: 1.0, y: 0.5)
        gradient.colors = [startColor , endColor]

        layer.addSublayer(gradient)
    }

    func addFourPinsConstraints(_ view: UIView, top: CGFloat, bottom: CGFloat, leading: CGFloat, trailing: CGFloat) {
        view.translatesAutoresizingMaskIntoConstraints = false

        let topConstraint = NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: top)
        let bottomConstraint = NSLayoutConstraint(item: view, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: bottom)

        let leadingConstraint = NSLayoutConstraint(item: view, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: leading)
        let trailingConstraint = NSLayoutConstraint(item: view, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: trailing)

        addConstraints([topConstraint, bottomConstraint, leadingConstraint, trailingConstraint])
    }

    func dropShadow(color: UIColor) {

        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: -1, height: 1)
        self.layer.shadowRadius = 1

        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
    }
}
