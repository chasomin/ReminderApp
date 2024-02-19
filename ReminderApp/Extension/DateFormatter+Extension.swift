//
//  DateFormatter+Extension.swift
//  ReminderApp
//
//  Created by 차소민 on 2/19/24.
//

import UIKit

extension Date {
    func dateToString() -> String {
        let format = DateFormatter()
        format.dateFormat = "yy년 M월 d일"
        return format.string(from: self)
    }
}

extension String {
    func stringToDate() -> Date {
        let format = DateFormatter()
        format.dateFormat = "yy년 M월 d일"
        return format.date(from: self) ?? Date()
    }
}
