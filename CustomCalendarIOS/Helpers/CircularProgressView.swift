//
//  ProgressView.swift
//
//
//  Created by iMac Limited on 20/07/18.
//  Copyright © 2018 Umair Afzal. All rights reserved.
//

import UIKit

class CircularProgressView: KDCircularProgress {
    var counter = 0.0
    var pointsAsDouble = 0.0
    var timer:Timer?

    var text: String = "" {
        didSet {
            textLabel.text = text
        }
    }

    var todayPointsText = "Points"

    var attributedText: String = "" {

        didSet {
            let myAttribute = [ NSAttributedStringKey.font: UIFont.appThemeThinFontWithSize(100.0), NSAttributedStringKey.foregroundColor: UIColor.lightGray]
            let myString = NSMutableAttributedString(string: attributedText, attributes: myAttribute )

            let attrString = NSAttributedString(string: " \n \(todayPointsText)")

            let myRange = NSRange(location: myString.length, length: attrString.length)
            myString.append(attrString)
            myString.addAttributes([ NSAttributedStringKey.font: UIFont.appThemeFontWithSize(26), NSAttributedStringKey.foregroundColor: UIColor.lightGray], range: myRange)

            textLabel.attributedText = myString
        }
    }

    internal var textLabel: UILabel = UILabel()

    init() {
        super.init(frame: CGRect.zero)

        setup()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        setup()
    }

    required internal init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        setup()
    }

    func setup() {
        textLabel.textAlignment = .center
        textLabel.numberOfLines = 0
        textLabel.lineBreakMode = .byWordWrapping
        textLabel.adjustsFontSizeToFitWidth = true

        addSubview(textLabel)

        textLabel.translatesAutoresizingMaskIntoConstraints = false
        addFourPinsConstraints(textLabel, top: 0.0, bottom: 0.0, leading: 0.0, trailing: 0.0)
    }

    func setupPoint(_ points:String) {
        textLabel.textAlignment = .center
        textLabel.numberOfLines = 0
        textLabel.lineBreakMode = .byWordWrapping

        addSubview(textLabel)

        textLabel.translatesAutoresizingMaskIntoConstraints = false
        addFourPinsConstraints(textLabel, top: 0.0, bottom: 0.0, leading: 0.0, trailing: 0.0)

        textLabel.text = "\(points)" + " \n\(todayPointsText)"

        let myAttribute = [ NSAttributedStringKey.font: UIFont.appThemeFontWithSize(110.0), NSAttributedStringKey.foregroundColor: UIColor.lightGray]
        let myString = NSMutableAttributedString(string: points, attributes: myAttribute )

        let attrString = NSAttributedString(string: " \n\(todayPointsText)")

        let myRange = NSRange(location: myString.length, length: attrString.length)
        myString.append(attrString)

        myString.addAttributes([ NSAttributedStringKey.font: UIFont.appThemeFontWithSize(24.0), NSAttributedStringKey.foregroundColor: UIColor.lightGray], range: myRange)

        textLabel.attributedText = myString
    }

    func synchronizingMode() {
        let myAttribute = [NSAttributedStringKey.font: UIFont.appThemeFontWithSize(40.0), NSAttributedStringKey.foregroundColor: UIColor.lightGray]
        let myString = NSMutableAttributedString(string: "Syncing"+"\n", attributes: myAttribute )
        let attrString = NSAttributedString(string: "")
        let myRange = NSRange(location: myString.length, length: attrString.length)

        myString.append(attrString)
        myString.addAttributes([ NSAttributedStringKey.font: UIFont.appThemeFontWithSize(14.0), NSAttributedStringKey.foregroundColor: UIColor.black], range: myRange)
        textLabel.attributedText = myString
    }

    func animate() {

        if counter < pointsAsDouble {

            UIView.transition(with: textLabel, duration: 0.0001, options: UIViewAnimationOptions(), animations: { () -> Void in
                self.counter += 1
                self.textLabel.text = "\(self.counter)"
                self.setupPoint("\(Int(self.counter))")
                }, completion: nil)

        } else {
            counter = 0
            timer!.invalidate()
        }
    }

}
