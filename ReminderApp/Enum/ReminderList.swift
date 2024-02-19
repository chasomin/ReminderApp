//
//  ReminderList.swift
//  ReminderApp
//
//  Created by 차소민 on 2/14/24.
//

import UIKit
import RealmSwift

enum ReminderList: String, CaseIterable {
    case today = "오늘"
    case schedule = "예정"
    case all = "전체"
    case flag = "깃발 표시"
    case done = "완료됨"
    
    var image: UIImage? {
        switch self {
        case .today:
            UIImage(systemName: "calendar")
        case .schedule:
            UIImage(systemName: "calendar")
        case .all:
            UIImage(systemName: "tray.fill")
        case .flag:
            UIImage(systemName: "flag.fill")
        case .done:
            UIImage(systemName: "checkmark")
        }
    }
    
    var color: UIColor {
        switch self {
        case .today:
            UIColor.systemBlue
        case .schedule:
            UIColor.systemRed
        case .all:
            UIColor.lightGray
        case .flag:
            UIColor.systemYellow
        case .done:
            UIColor.systemGray
        }
    }
    
    func getReminderCount(data: Results<ReminderModel>) -> Int {
        let realm = try! Realm()
        let repository = ReminderModelRepository()
        switch self {
        case .today:
            return repository.read(filter: .today).count
        case .schedule:
            return repository.read(filter: .schedule).count
        case .all:
            return repository.read(filter: .all).count
        case .flag:
            return repository.read(filter: .flag).count
        case .done:
            return repository.read(filter: .done).count
        }
    }
}
