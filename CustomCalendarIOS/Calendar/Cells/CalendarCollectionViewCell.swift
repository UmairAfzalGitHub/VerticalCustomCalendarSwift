//
//  CalendarCollectionViewCell.swift
//
//
//  Created by iMac on 16/08/2018.
//  Copyright © 2018 Umair Afzal. All rights reserved.
//

import UIKit

class CalendarCollectionViewCell: UICollectionViewCell {

    // MARK: - Constants & Variables

    @IBOutlet weak var activityProgressView: CircularProgressView!

    var currentDate: Date!
    var isCellSelectable: Bool?

    var textColor: UIColor = UIColor.white {

        didSet {
            activityProgressView.textLabel.textColor = textColor
            activityProgressView.trackColor = textColor
        }
    }

    var text: String = "" {

        didSet {
            activityProgressView.text = text
        }
    }

    var daySteps: Int = 0

    var dayPoints: Double = 0.0 {

        didSet {

            // If you wanna make the cell selectable on specific condition
//            if dayPoints > 0.0 || daySteps < 0 {
//                isCellSelectable = true
//
//            } else {
//                isCellSelectable = false
//            }
            
            isCellSelectable = true
            activityProgressView.angle = dayPoints * 4.0 * 3.6
        }
    }

    // MARK: - UICollectionViewCell methods

    override func awakeFromNib() {
        super.awakeFromNib()

        activityProgressView.backgroundColor = UIColor.clear
        activityProgressView.startAngle = -90
        activityProgressView.progressThickness = 0.50

        activityProgressView.trackThickness = 0.0
        activityProgressView.clockwise = true
        activityProgressView.gradientRotateSpeed = 2
        activityProgressView.roundedCorners = true
        activityProgressView.glowMode = KDCircularProgressGlowMode.noGlow
        activityProgressView.set(UIColor.blue)
        activityProgressView.trackColor = UIColor.clear
        activityProgressView.textLabel.attributedText = nil
    }

    func selectedForLabelColor(_ color: UIColor) {

    }

    func deSelectedForLabelColor(_ color: UIColor) {
        activityProgressView.textLabel.textColor = color
    }

    func setTodayCellColor(_ backgroundColor: UIColor) {
        activityProgressView.textLabel.textColor  = UIColor.black
    }

}
