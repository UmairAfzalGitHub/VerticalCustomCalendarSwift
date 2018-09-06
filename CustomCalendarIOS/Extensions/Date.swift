//
//  NSDate+.swift
//  
//
//  Created by iMac on 02/08/2018.
//  Copyright © 2018 Umair Afzal. All rights reserved.
//

import Foundation
import UIKit

extension Date {
    
    init(dateString:String) {
        let dateStringFormatter = DateFormatter()
        dateStringFormatter.dateFormat = "yyyy-MM-dd"
        dateStringFormatter.locale = Locale(identifier: "en_US_POSIX")
        let d = dateStringFormatter.date(from: dateString) ?? Date()
        self.init(timeInterval:0, since:d)
    }

    func toTimeString() -> String {
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: self)
        let minutes = calendar.component(.minute, from: self)
        let seconds = calendar.component(.second, from: self)
        return "\(hour):\(minutes):\(seconds)"
    }

    func datesBetweenGivenDates(_ startDate:Date,endDate:Date) -> [String] {
        var dates:[String] = []

        var date = startDate
        // first date
        let endDate = endDate // last date
        let calendar = currentCalendar()

        // Formatter for printing the date, adjust it according to your needs:
        let fmt = DateFormatter()
        fmt.dateFormat = "yyyy/MM/dd"

        // While date <= endDate ...
        while date.compare(endDate) != .orderedDescending {
            dates.append(fmt.string(from: date))
            // Advance by one day:
            date = (calendar as NSCalendar).date(byAdding: .day, value: 1, to: date, options: [])!
        }

        return dates
    }

    func sharedCalendar() {

    }

    func firstDayOfMonth () -> Date {
        let calendar = currentCalendar()
        var dateComponent = (calendar as NSCalendar).components([.year, .month, .day ], from: self)
        dateComponent.day = 1
        return calendar.date(from: dateComponent)!
    }

    init(year : Int, month : Int, day : Int) {

        let calendar = Calendar.current
        var dateComponent = DateComponents()
        dateComponent.year = year
        dateComponent.month = month
        dateComponent.day = day
        self.init(timeInterval:0, since:calendar.date(from: dateComponent)!)
    }

    func dateByAddingMonths(_ months : Int ) -> Date {
        let calendar = currentCalendar()
        var dateComponent = DateComponents()
        dateComponent.month = months
        return (calendar as NSCalendar).date(byAdding: dateComponent, to: self, options: NSCalendar.Options.matchNextTime)!
    }

    func dateByAddingDays(_ days : Int ) -> Date {
        let calendar = currentCalendar()
        var dateComponent = DateComponents()
        dateComponent.day = days
        return (calendar as NSCalendar).date(byAdding: dateComponent, to: self, options: NSCalendar.Options.matchNextTime)!
    }

    func hour() -> Int {
        let calendar = currentCalendar()
        let dateComponent = (calendar as NSCalendar).components(.hour, from: self)
        return dateComponent.hour!
    }

    func second() -> Int {
        let calendar = currentCalendar()
        let dateComponent = (calendar as NSCalendar).components(.second, from: self)
        return dateComponent.second!
    }

    func minute() -> Int {
        let calendar = currentCalendar()
        let dateComponent = (calendar as NSCalendar).components(.minute, from: self)
        return dateComponent.minute!
    }

    func day() -> Int {
        let calendar = currentCalendar()
        let dateComponent = (calendar as NSCalendar).components(.day, from: self)
        return dateComponent.day!
    }

    func weekday() -> Int {
        let calendar = currentCalendar()
        let dateComponent = (calendar as NSCalendar).components(.weekday, from: self)
        return dateComponent.weekday!
    }

    func month() -> Int {
        let calendar = currentCalendar()
        let dateComponent = (calendar as NSCalendar).components(.month, from: self)
        return dateComponent.month!
    }

    func year() -> Int {
        let calendar = currentCalendar()
        let dateComponent = (calendar as NSCalendar).components(.year, from: self)
        return dateComponent.year!
    }

    func numberOfDaysInMonth() -> Int {
        let calendar = currentCalendar()
        let days = (calendar as NSCalendar).range(of: NSCalendar.Unit.day, in: NSCalendar.Unit.month, for: self)
        return days.length
    }

    func dateByIgnoringTime() -> Date {
        let calendar = currentCalendar()
        let dateComponent = (calendar as NSCalendar).components([.year, .month, .day ], from: self)
        return calendar.date(from: dateComponent)!
    }

    func monthNameFull() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM yyyy"
        return dateFormatter.string(from: self)
    }

    func isSunday() -> Bool {
        return (self.getWeekday() == 1)
    }

    func isMonday() -> Bool {
        return (self.getWeekday() == 2)
    }

    func isTuesday() -> Bool {
        return (self.getWeekday() == 3)
    }

    func isWednesday() -> Bool {
        return (self.getWeekday() == 4)
    }

    func isThursday() -> Bool {
        return (self.getWeekday() == 5)
    }

    func isFriday() -> Bool {
        return (self.getWeekday() == 6)
    }

    func isSaturday() -> Bool {
        return (self.getWeekday() == 7)
    }

    func getWeekday() -> Int {
        let calendar = Calendar.current
        return (calendar as NSCalendar).components( .weekday, from: self).weekday!
    }

    func isToday() -> Bool {
        return self.isDateSameDay(Date())
    }

    func isDateSameDay(_ date: Date) -> Bool {

        return (self.day() == date.day()) && (self.month() == date.month() && (self.year() == date.year()))

    }

    func currentCalendar() -> Calendar {
        let calendar = Calendar.current
        // calendar.timeZone = NSTimeZone(name: kTimeZone)!

        return calendar
    }

}
