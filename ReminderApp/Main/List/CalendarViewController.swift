//
//  CalendarViewController.swift
//  ReminderApp
//
//  Created by 차소민 on 2/19/24.
//

import UIKit
import FSCalendar
import SnapKit
import RealmSwift

class CalendarViewController: BaseViewController {

    let realm = try! Realm()
    let calendar = FSCalendar()
    var calendarData: ((Results<ReminderModel>) -> Void)?
    var seleteDate: Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let modal = self.sheetPresentationController {
            modal.detents = [.medium()]
        }
        calendar.delegate = self
        calendar.dataSource = self
    }
    
    override func configureHierarchy() {
        view.addSubview(calendar)
    }
    
    override func configureLayout() {
        calendar.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        calendar.scrollDirection = .vertical
        calendar.backgroundColor = .white
    }
}




extension CalendarViewController: FSCalendarDelegate, FSCalendarDataSource {
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        let start = Calendar.current.startOfDay(for: date)
        
        let end: Date = Calendar.current.date(byAdding: .day, value: 1, to: start) ?? Date()
        
        let predicate = NSPredicate(format: "deadline >= %@ && deadline < %@", start as NSDate, end as NSDate)
        
        return realm.objects(ReminderModel.self).filter(predicate).count
    }
    //TODO: 선택했던 날짜 기억하게 하기~
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let start = Calendar.current.startOfDay(for: date)
        
        let end: Date = Calendar.current.date(byAdding: .day, value: 1, to: start) ?? Date()
        
        let predicate = NSPredicate(format: "deadline >= %@ && deadline < %@", start as NSDate, end as NSDate)
        
        seleteDate = calendar.selectedDate
        calendarData?(realm.objects(ReminderModel.self).filter(predicate))
        dismiss(animated: true)
    }
}
