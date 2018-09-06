//
//  CalendarHeaderView.swift
//
//
//  Created by iMac Limited on 16/08/18.
//  Copyright © 2018 Umair Afzal. All rights reserved.
//

import UIKit

class CalendarHeaderView: UICollectionReusableView {

    @IBOutlet weak var lblFirst: UILabel!
    @IBOutlet weak var lblSecond: UILabel!
    @IBOutlet weak var lblThird: UILabel!
    @IBOutlet weak var lblFourth: UILabel!
    @IBOutlet weak var lblFifth: UILabel!
    @IBOutlet weak var lblSixth: UILabel!
    @IBOutlet weak var lblSeventh: UILabel!
    @IBOutlet weak var lblTitle: UILabel!

    @IBOutlet weak var daysLabelView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()

/*        let calendar = NSCalendar.currentCalendar()
        let weeksDayList = calendar.shortWeekdaySymbols

        if NSCalendar.currentCalendar().firstWeekday == 2 {
            lblFirst.text = weeksDayList[1]
            lblSecond.text = weeksDayList[2]
            lblThird.text = weeksDayList[3]
            lblFourth.text = weeksDayList[4]
            lblFifth.text = weeksDayList[5]
            lblSixth.text = weeksDayList[6]
            lblSeventh.text = weeksDayList[0]
        } else {
            lblFirst.text = weeksDayList[0]
            lblSecond.text = weeksDayList[1]
            lblThird.text = weeksDayList[2]
            lblFourth.text = weeksDayList[3]
            lblFifth.text = weeksDayList[4]
            lblSixth.text = weeksDayList[5]
            lblSeventh.text = weeksDayList[6]
        } */

        let color = UIColor.lightGray

        lblFirst.textColor = color
        lblSecond.textColor = color
        lblThird.textColor = color
        lblFourth.textColor = color
        lblFifth.textColor = color
        lblSixth.textColor = color
        lblSeventh.textColor = color

        lblFirst.text = "M"
        lblSecond.text = "T"
        lblThird.text = "W"
        lblFourth.text = "T"
        lblFifth.text = "F"
        lblSixth.text = "S"
        lblSeventh.text = "S"

    }

    func updateWeekendLabelColor(_ color: UIColor) {
        if Calendar.current.firstWeekday == 2 {
            lblSixth.textColor = color
            lblSeventh.textColor = color
        } else {
            lblFirst.textColor = color
            lblSeventh.textColor = color
        }
    }

    func updateWeekdaysLabelColor(_ color: UIColor) {
        if Calendar.current.firstWeekday == 2 {
            lblFirst.textColor = color
            lblSecond.textColor = color
            lblThird.textColor = color
            lblFourth.textColor = color
            lblFifth.textColor = color
        } else {
            lblSecond.textColor = color
            lblThird.textColor = color
            lblFourth.textColor = color
            lblFifth.textColor = color
            lblSixth.textColor = color
        }
    }

}
