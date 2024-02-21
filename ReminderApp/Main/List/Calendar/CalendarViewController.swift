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

final class CalendarViewController: BaseViewController {

    private let calendar = FSCalendar()
    
    private let repository = ReminderModelRepository()
    
    var calendarData: ((Results<ReminderModel>) -> Void)?
    var selectedDate: ((Date) -> Void)?
    var selected: Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let modal = self.sheetPresentationController {
            modal.detents = [.medium()]
        }
        calendar.delegate = self
        calendar.dataSource = self
        
        calendar.currentPage = selected ?? Date()
        calendar.select(selected)
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
        

        return repository.read(type: ReminderModel.self).filter(predicate).count
        
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let start = Calendar.current.startOfDay(for: date)
        
        let end: Date = Calendar.current.date(byAdding: .day, value: 1, to: start) ?? Date()
        
        let predicate = NSPredicate(format: "deadline >= %@ && deadline < %@", start as NSDate, end as NSDate)
        
        if let selectedDate = calendar.selectedDate {
            self.selectedDate?(selectedDate)
            selected = selectedDate
        }
        calendarData?(repository.read(type: ReminderModel.self).filter(predicate))

        dismiss(animated: true)
    }
    

}
