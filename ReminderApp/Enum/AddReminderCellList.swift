//
//  AddReminderCellList.swift
//  ReminderApp
//
//  Created by 차소민 on 2/14/24.
//

import Foundation

enum AddReminderCellList: Int, CaseIterable {
    case deadline = 1
    case tag
    case priority
    case image
    case box
    
    var title: String {
        switch self {
        case .deadline:
            "마감일"
        case .tag:
            "태그"
        case .priority:
            "우선 순위"
        case .image:
            "이미지 추가"
        case .box:
            "목록"
        }
    }
    
    func setPriority(data: ReminderModel) -> String {
        switch data.priority {
        case 0 :
            return "없음"
        case 1:
            return "낮음"
        case 2:
            return "중간"
        case 3:
            return "높음"
        default:
            return ""
        }
    }
    
    func setSubTitle(data: ReminderModel, boxData: ReminderBox) -> String{
        switch self {
        case .deadline:
            data.deadline.dateToString()
        case .tag:
            data.tag ?? ""
        case .priority:
            setPriority(data: data)
        case .image:
            ""
        case .box:
            boxData.boxTitle
        }
    }
    
    func setCellSize() -> CGFloat {
        switch self {
        case .image:
            100
        default:
            50
        }
    }
}
