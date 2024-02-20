//
//  ReminderModel.swift
//  ReminderApp
//
//  Created by 차소민 on 2/15/24.
//

import Foundation
import RealmSwift


final class ReminderBox: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var title: String
    @Persisted var regDate: Date
    @Persisted var color: Int
    @Persisted var icon: Int
    
    @Persisted var reminder: List<ReminderModel>
    
    convenience init(title: String, regDate: Date, color: Int, icon: Int) {
        self.init()
        
        self.title = title
        self.regDate = regDate
        self.color = color
        self.icon = icon
    }
}


final class ReminderModel: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var title: String
    @Persisted var memo: String?
    @Persisted var deadline: Date
    @Persisted var tag: String?
    @Persisted var priority: Int
    @Persisted var isDone: Bool
//    @Persisted var image
    
    
    convenience init(title: String, memo: String? = nil, deadline: Date, tag: String?, priority: Int) {
        self.init()

        self.title = title
        self.memo = memo
        self.deadline = deadline
        self.tag = tag
        self.priority = priority
        self.isDone = false
    }
}
