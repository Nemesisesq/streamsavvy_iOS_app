//
//  CalendarViewController.swift
//  Stream Savvy
//
//  Created by Carl Lewis on 12/6/16.
//  Copyright © 2016 StreamSavvy. All rights reserved.
//

import UIKit

class CalendarViewController: UIViewController, FSCalendarDataSource, FSCalendarDelegate {
    
    
    @IBOutlet var calendar: FSCalendar!
    @IBOutlet var calendarHeightConstraint: NSLayoutConstraint!
    
    private let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter
    }()
    private let gregorian: NSCalendar! = NSCalendar(calendarIdentifier:NSCalendar.Identifier.gregorian)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.calendar.scopeGesture.isEnabled = true
         self.calendar.appearance.caseOptions = [.headerUsesUpperCase,.weekdayUsesUpperCase]

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //func minimumDate(for calendar: FSCalendar) -> Date {
    //    return self.formatter.date(from: "2015/01/01")!
    ///}
    
    //func maximumDate(for calendar: FSCalendar) -> Date {
    //    return self.formatter.date(from: "2016/10/31")!
    //}
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        let day: Int! = self.gregorian.component(.day, from: date)
        return day % 5 == 0 ? day/5 : 0;
    }
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        NSLog("change page to \(self.formatter.string(from: calendar.currentPage))")
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        NSLog("calendar did select date \(self.formatter.string(from: date))")
        if monthPosition == .previous || monthPosition == .next {
            calendar.setCurrentPage(date, animated: true)
        }
    }
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        calendarHeightConstraint.constant = bounds.height
        view.layoutIfNeeded()
    }
    
    //func calendar(_ calendar: FSCalendar, imageFor date: Date) -> UIImage? {
      //  let day: Int! = self.gregorian.component(.day, from: date)
       // return [13,24].contains(day) ? UIImage(named: "icon_cat") : nil
    //}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
