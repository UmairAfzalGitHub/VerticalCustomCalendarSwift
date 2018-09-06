//
//  CalendarViewController.swift
//
//
//  Created by iMac Limited on 05/08/18.
//  Copyright © 2018 Umair Afzal. All rights reserved.
//

import UIKit

struct Defaults {
    // Values
    static let startYear = 2015
    static let endYear = 2016
    static let multiSelection = false

    // Colors
    static let dayDisabledTintColor = UIColor.lightGray
    static let weekdayTintColor = UIColor.gray
    static let weekendTintColor = UIColor.gray
    static let dateSelectionColor = UIColor.clear
    static let monthTitleColor = Colors.themeColor
    static let todayTintColor = UIColor.clear

    static let tintColor = Colors.PomegranateColor
    static let barTintColor = UIColor.white

    // HeaderSize
    static let headerSize = CGSize(width: 100, height: 60)
    static let footerSize = CGSize(width: 100, height: 2)

}

struct Colors {
    static let BlueColor = UIColor(red: (0/255), green: (21/255), blue: (63/255), alpha: 1.0)
    static let YellowColor = UIColor(red: (241/255), green: (196/255), blue: (15/255), alpha: 1.0)
    static let LightGrayColor = UIColor(red: (230/255), green: (230/255), blue: (230/255), alpha: 1.0)
    static let OrangeColor = UIColor(red: (233/255), green: (159/255), blue: (94/255), alpha: 1.0)
    static let LightGreenColor = UIColor(red: (158/255), green: (206/255), blue: (77/255), alpha: 1.0)

    static let EmeraldColor = UIColor(red: (46/255), green: (204/255), blue: (113/255), alpha: 1.0)
    static let SunflowerColor = UIColor(red: (241/255), green: (196/255), blue: (15/255), alpha: 1.0)
    static let PumpkinColor = UIColor(red: (211/255), green: (84/255), blue: (0/255), alpha: 1.0)
    static let AsbestosColor = UIColor(red: (127/255), green: (140/255), blue: (141/255), alpha: 1.0)
    static let AmethystColor = UIColor(red: (155/255), green: (89/255), blue: (182/255), alpha: 1.0)
    static let PeterRiverColor = UIColor(red: (52/255), green: (152/255), blue: (219/255), alpha: 1.0)
    static let PomegranateColor = UIColor(red: (192/255), green: (57/255), blue: (43/255), alpha: 1.0)
    static let themeColor = UIColor(red: (0/255), green: (208/255), blue: (208/255), alpha: 1.0)
}

// MARK: -

private let reuseIdentifier = "Cell"
private let headerReuseIdentifier = "CollectionViewHeader"
private let footerReuseIdentifier = "CollectionViewFooter"

// MARK: - CalendarCollectionViewControllerDelegate

protocol CalendarViewControllerDelegate {

    func calendarCollectionViewController(_: CalendarViewController, didCancel error : NSError)

    func calendarCollectionViewController(_: CalendarViewController, didSelectDate date : Date)

    func calendarCollectionViewController(_: CalendarViewController, didSelectMultipleDate dates : [Date])

}

extension CalendarViewControllerDelegate {

    func calendarCollectionViewController(_: CalendarViewController, didCancel error : NSError) {}

    func calendarCollectionViewController(_: CalendarViewController, didSelectDate date : Date) {}

    func calendarCollectionViewController(_: CalendarViewController, didSelectMultipleDate dates : [Date]) {}

}

class CalendarViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    // MARK: - Constants & Variables

    @IBOutlet weak var collectionView: UICollectionView!

    var calendarDelegate: CalendarViewControllerDelegate?

    var multiSelectEnabled: Bool
    var tintColor: UIColor

    var dayDisabledTintColor: UIColor
    var weekdayTintColor: UIColor
    var weekendTintColor: UIColor
    var todayTintColor: UIColor
    var dateSelectionColor: UIColor
    var monthTitleColor: UIColor

    // new options
    var startDate: Date?
    var hightlightsToday: Bool = true
    var hideDaysFromOtherMonth: Bool = true
    var barTintColor: UIColor

    var backgroundImage: UIImage?
    var backgroundColor: UIColor?

    fileprivate var gregorianCalendar = Calendar.current

    fileprivate var arrSelectedDates = [Date]()
    fileprivate(set)  var startYear: Int
    fileprivate(set)  var endYear: Int

    var calendarDatesPoints:[Double] = []
    var calendarDates:[String] = []
    var calendarDatePoints: [CalendarDailyPoints]
    var isComingFromDashBoard = true
    var xCount = 0

    // MARK: - Init & deinit

    //    init() {
    //        super.init(nibName: "CalendarViewController", bundle: NSBundle.mainBundle())
    //    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    internal init(startYear: Int, endYear: Int, multiSelection: Bool, selectedDates: [Date]?, dates:[String],points:[Double]) {
        calendarDatePoints = []
        self.startYear = startYear
        self.endYear = endYear
        self.multiSelectEnabled = multiSelection

        // Text color initializations
        self.tintColor = Defaults.tintColor
        self.barTintColor = Defaults.barTintColor
        self.dayDisabledTintColor = Defaults.dayDisabledTintColor
        self.weekdayTintColor = Defaults.weekdayTintColor
        self.weekendTintColor = Defaults.weekendTintColor
        self.dateSelectionColor = Defaults.dateSelectionColor
        self.monthTitleColor = Defaults.monthTitleColor
        self.todayTintColor = Defaults.todayTintColor

        if dates.count>0 {
            calendarDates = dates
            calendarDatesPoints = points
        }

        // Layout creation
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        layout.headerReferenceSize = Defaults.headerSize
        layout.footerReferenceSize = Defaults.footerSize

        if let _ = selectedDates {
            self.arrSelectedDates.append(contentsOf: selectedDates!)
        }
        // let collectionViewLayout = collectionView.collectionViewLayout

        super.init(nibName: "CalendarViewController", bundle: Bundle.main)
    }

    // MARK: - UIViewController methods

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBarUI()
        setupViewController()
    }

    override func viewDidAppear(_ animated: Bool) {
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Helper methods

    func setupNavigationBarUI() {
        title = "Calendar"
        self.navigationController?.navigationBar.isTranslucent = false

        let cancelButton = UIBarButtonItem(title:"Cancel", style: .plain, target: self, action: #selector(backButtonTapped)) // Cancel
        let homeButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(homeButtonTapped))
        self.navigationItem.leftBarButtonItem = cancelButton
        self.navigationItem.rightBarButtonItem = homeButton
    }

    func setupViewController() {
        // gregorianCalendar.timeZone = NSTimeZone(name: kTimeZone)!
        gregorianCalendar.firstWeekday = 2

        // let startDate = NSDate(year: 2017, month: 1, day: 1)
        // print(numberOfWeeks(startDate))

        // setup collectionview

        self.collectionView?.backgroundColor = UIColor.clear
        self.collectionView?.showsHorizontalScrollIndicator = false
        self.collectionView?.showsVerticalScrollIndicator = false

        // Register cell classes
        self.collectionView!.register(UINib(nibName: "CalendarCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView!.register(UINib(nibName: "CalendarHeaderView", bundle: Bundle.main), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerReuseIdentifier)
        self.collectionView!.register(UINib(nibName: "CalendarFooterView", bundle: Bundle.main), forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: footerReuseIdentifier)

        if backgroundImage != nil {
            self.collectionView!.backgroundView =  UIImageView(image: backgroundImage)

        } else if backgroundColor != nil {
            self.collectionView?.backgroundColor = backgroundColor

        } else {
            self.collectionView?.backgroundColor = UIColor.white
        }

        // Developer's Note: Using a little delay because app was crashing sometimes, UICollectionViewLayoutAttributes

        let delayTime = DispatchTime.now() + Double(Int64(0.4 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)

        DispatchQueue.main.asyncAfter(deadline: delayTime) { 
            self.scrollToToday()

        }

//        DispatchQueue.main.async { () -> Void in
//            self.scrollToToday()
//        }
    }

    // MARK: - UICollectionViewDataSource

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {

        return Defaults.footerSize
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return Defaults.headerSize
    }

    internal func numberOfSections(in collectionView: UICollectionView) -> Int {

        if startYear > endYear {
            return 0
        }

        let numberOfMonths = 12 * (endYear - startYear) + 12
        return numberOfMonths
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        let startDate = Date(year: startYear, month: 1, day: 1)
        let firstDayOfMonth = startDate.dateByAddingMonths(section)
        let totalNumber = 7 * numberOfWeeks(firstDayOfMonth)

        return totalNumber
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CalendarCollectionViewCell
        cell.daySteps = 0
        cell.dayPoints = 0.0

        let calendarStartDate = Date(year:startYear, month: 1, day: 1)
        let firstDayOfThisMonth = calendarStartDate.dateByAddingMonths(indexPath.section)

        // let prefixDays = firstDayOfThisMonth.weekday() - gregorianCalendar!.firstWeekday

        var prefixDays = firstDayOfThisMonth.weekday() - 1

        if firstDayOfThisMonth.isSunday() { // If sunday
            prefixDays = 7
        }

        prefixDays -= 1

        if indexPath.row >= prefixDays && indexPath.row < firstDayOfThisMonth.numberOfDaysInMonth() + prefixDays {

            let currentDate = firstDayOfThisMonth.dateByAddingDays(indexPath.row-prefixDays)

            let nextMonthFirstDay = firstDayOfThisMonth.dateByAddingDays(firstDayOfThisMonth.numberOfDaysInMonth()-1)
            cell.currentDate = currentDate

            let formatter = DateFormatter()
            formatter.dateFormat = "YYYY-MM-dd"

            let dateForIndexPath = formatter.string(from: cell.currentDate)

            if let index = calendarDatePoints.index(where: {

                if $0.date == dateForIndexPath {

                    return true
                }

                return false

            }) {

                if index < calendarDatePoints.count {
                    cell.daySteps = calendarDatePoints[index].steps
                    cell.dayPoints = calendarDatePoints[index].points
                }
            }

            cell.text = "\(cell.currentDate.day())"

            if arrSelectedDates.filter({ $0.isDateSameDay(currentDate)
            }).count > 0 && (firstDayOfThisMonth.month() == currentDate.month()) {

                cell.selectedForLabelColor(dateSelectionColor)

            } else {
                cell.deSelectedForLabelColor(weekdayTintColor)

                if cell.currentDate.isSaturday() || cell.currentDate.isSunday() {
                    cell.textColor = weekendTintColor
                }

                if currentDate > nextMonthFirstDay {

                    if hideDaysFromOtherMonth {
                        cell.textColor = UIColor.clear
                    } else {
                        cell.textColor = self.dayDisabledTintColor
                    }
                }

                if currentDate.isToday() && hightlightsToday {
                    cell.setTodayCellColor(todayTintColor)
                    cell.isCellSelectable = true
                    cell.activityProgressView.textLabel.textColor  = UIColor.red
                }

                if startDate != nil {

                    if Calendar.current.startOfDay(for: cell.currentDate as Date) < Calendar.current.startOfDay(for: startDate!) {
                        cell.textColor = self.dayDisabledTintColor
                    }
                }
            }

        } else {
            cell.deSelectedForLabelColor(weekdayTintColor)
            let previousDay = firstDayOfThisMonth.dateByAddingDays(-( prefixDays - indexPath.row))
            cell.currentDate = previousDay
            cell.text = "\(previousDay.day())"

            if hideDaysFromOtherMonth {
                cell.textColor = UIColor.clear
            } else {
                cell.textColor = self.dayDisabledTintColor
            }
        }

        // make text bold for all selectable dates
//        if cell.isCellSelectable == true {
//            cell.activityProgressView.textLabel.textColor  = UIColor.black
//        }

        cell.backgroundColor = UIColor.clear

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let rect = UIScreen.main.bounds
        let screenWidth = rect.size.width - 7
        return CGSize(width: screenWidth/7, height: screenWidth/7)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(5, 0, 5, 0) // top,left,bottom,right
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        if kind == UICollectionElementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerReuseIdentifier, for: indexPath) as! CalendarHeaderView

            let startDate = Date(year: self.startYear, month: 1, day: 1)
            let firstDayOfMonth = startDate.dateByAddingMonths(indexPath.section)

            header.lblTitle.text = firstDayOfMonth.monthNameFull()
            header.lblTitle.textColor = monthTitleColor
            //print("\(startDate), FirstDay of month: \(firstDayOfMonth),\(firstDayOfMonth.monthNameFull())")

            header.backgroundColor = UIColor.clear
            header.daysLabelView.isHidden = true

            return header

        } else if kind == UICollectionElementKindSectionFooter {
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionFooter, withReuseIdentifier: footerReuseIdentifier, for: indexPath) as! CalendarFooterView
            return footer
        }

        return UICollectionReusableView()
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CalendarCollectionViewCell

        if cell.isCellSelectable == true {
            let formatter = DateFormatter()
            formatter.dateStyle = .short
            //cell.currentDate = cell.currentDate.addingTimeInterval(60*60*24*(1))
            cell.selectedForLabelColor(dateSelectionColor)
            calendarDelegate?.calendarCollectionViewController(self, didSelectDate: cell.currentDate as Date)
            self.dismiss(animated: true, completion: nil)
            print(cell.currentDate)
        }
    }

    // MARK: - UIButton Actions

    @objc func backButtonTapped() {
        calendarDelegate?.calendarCollectionViewController(self, didCancel: NSError(domain: "ErrorDomain", code: 2, userInfo: [ NSLocalizedDescriptionKey: "User Canceled Selection"]))

        dismiss(animated: true, completion: nil)
    }

    @objc internal func homeButtonTapped() {
        calendarDelegate?.calendarCollectionViewController(self, didSelectDate: Date())
        dismiss(animated: true, completion: nil)
    }

    func scrollToToday () {
        let today = Date()
        scrollToMonthForDate(today)
    }

    func scrollToMonthForDate (_ date: Date) {

        let month = date.month()
        let year = date.year()
        let section = ((year - startYear) * 12) + month
        let indexPath = IndexPath(row:1, section: section-1)

        self.collectionView?.scrollToIndexpathByShowingHeader(indexPath)
    }

    // MARK: Private methods

    fileprivate func numberOfWeeks(_ monthDate: Date) -> Int {
        let rangeOfUnit = NSCalendar.Unit.weekOfYear
        let inUnit = NSCalendar.Unit.month
        let weekRange = (gregorianCalendar as NSCalendar).range(of: rangeOfUnit, in: inUnit, for: monthDate)

        return weekRange.length
    }
}

class CalendarDailyPoints: NSObject {
    var date: String = ""
    var points: Double = 0.0
    var steps: Int = -1
}
