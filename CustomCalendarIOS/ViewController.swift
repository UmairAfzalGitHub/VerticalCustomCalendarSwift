//
//  ViewController.swift
//  CustomCalendarIOS
//
//  Created by Mac on 06/09/2018.
//  Copyright © 2018 UmairAFzal. All rights reserved.
//

import UIKit

class ViewController: UIViewController, CalendarViewControllerDelegate {

    @IBOutlet weak var dateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func calendarButtonTapped(_ sender: Any) {
        let calendarViewController = CalendarViewController(startYear: 2016, endYear: 2022, multiSelection: false, selectedDates: [], dates: [], points: [])
        calendarViewController.calendarDelegate = self
        let navigationController = UINavigationController()
        navigationController.viewControllers = [calendarViewController]
        self.present(navigationController, animated: true, completion: nil)
    }
    
    // MARK: - CalendarViewControllerDelegate
    
    func calendarCollectionViewController(_: CalendarViewController, didSelectDate date: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        dateLabel.text = "Selected date is \(dateFormatter.string(from: date))"
    }
}

