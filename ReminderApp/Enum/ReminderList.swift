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
    
    func getReminderCount(data: Results<ReminderModel>) -> Int{
        switch self {
        case .today:
            let format = DateFormatter()
            format.dateFormat = "yy년 MM월 dd일"
            format.timeZone = TimeZone(identifier: "Asia/Seoul")
            let today = format.string(from: Date())
            let result = data.filter {
                $0.deadline.contains(today)
            }
            return result.count
        case .schedule:
            let format = DateFormatter()
            format.dateFormat = "yy년 MM월 dd일"
            let result = data.filter {
                let deadline = format.date(from: $0.deadline)
                let today = Date()
                let koreaDate = today.addingTimeInterval(TimeInterval(9*60*60))
                return deadline?.compare(koreaDate) == .orderedDescending
            }
            return result.count
        case .all:
            return data.count
        case .flag:
            return 0
        case .done:
            return data.filter{$0.isDone == true}.count
        }
    }
}
