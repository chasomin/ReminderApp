//
//  ReminderModel.swift
//  ReminderApp
//
//  Created by 차소민 on 2/15/24.
//

import Foundation
import RealmSwift

final class ReminderModel: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var title: String
    @Persisted var memo: String?
    @Persisted var deadline: String
    @Persisted var tag: String?
    @Persisted var priority: Int
    @Persisted var isDone: Bool
//    @Persisted var image
    
    
    convenience init(title: String, memo: String? = nil, deadline: String, tag: String?, priority: Int) {
        self.init()
        self.title = title
        self.memo = memo
        self.deadline = deadline
        self.tag = tag
        self.priority = priority
        self.isDone = false
    }
}
