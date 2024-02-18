//
//  ReminderModelRepository.swift
//  ReminderApp
//
//  Created by 차소민 on 2/16/24.
//

import Foundation
import RealmSwift

final class ReminderModelRepository {
    private let realm = try! Realm()

    // MARK: Create
    func createItem(_ item: ReminderModel) {
        print(realm.configuration.fileURL)
        do {
            try realm.write {
                realm.add(item)
            }
        } catch {
            print(error)
        }
    }
    
    // MARK: Read
    func read() -> Results<ReminderModel> {
        realm.objects(ReminderModel.self)
    }
    
    func readDeadlineSort() -> Results<ReminderModel> {
        realm.objects(ReminderModel.self).sorted(byKeyPath: "deadline", ascending: true)
    }
    
    func readTitleSort() -> Results<ReminderModel> {
        realm.objects(ReminderModel.self).sorted(byKeyPath: "title", ascending: true)
    }
    
    func readPriorityFilter() -> Results<ReminderModel> {
        realm.objects(ReminderModel.self).where {
            $0.priority == 3
        }
    }
    
    func read(filter: ReminderList) -> Results<ReminderModel> {
        switch filter {
        case .today:
            realm.objects(ReminderModel.self).where {
                let format = DateFormatter()
                format.dateFormat = "yy년 MM월 dd일"
                format.timeZone = TimeZone(identifier: "Asia/Seoul")
                let today = format.string(from: Date())
                
                return $0.deadline.contains(today)
            }
        case .schedule:
//            realm.objects(ReminderModel.self).where {
//                let format = DateFormatter()
//                format.dateFormat = "yy년 MM월 dd일"
//                format.timeZone = TimeZone(identifier: "Asia/Seoul")
//                let today = format.string(from: Date())
                
//                let format = DateFormatter()
//                format.dateFormat = "yy년 MM월 dd일"
//                let deadline = format.date(from: "\($0.deadline)")
                
//                let today = Date()
//                let koreaDate = today.addingTimeInterval(TimeInterval(9*60*60))
                    
//                let result: Query<Bool> = deadline?.compare(koreaDate) == .orderedDescending
//                let result = $0.deadline > today
                
                realm.objects(ReminderModel.self) // TODO: ///
                
//            }
        case .all:
            realm.objects(ReminderModel.self)
        case .flag:
            realm.objects(ReminderModel.self)// TODO: ///
        case .done:
            realm.objects(ReminderModel.self).where {
                $0.isDone == true
            }
        }
    }
    
    func readFilterSearch(text: String) -> Results<ReminderModel> {
        realm.objects(ReminderModel.self).where {
            $0.title.contains(text, options: .caseInsensitive)
        }
    }
    
    // MARK: Update
    func updateItem(id: ObjectId, title: String, memo: String?, deadline: String, tag: String?, priority: Int) {
        do {
            try realm.write {
                realm.create(ReminderModel.self,
                             value: ["id":id, "title": title, "memo": memo, "deadline": deadline, "tag": tag, "priority": priority],
                             update: .modified)

            }
        } catch {
            
        }
    }
    
    func updateIsDone(_ item: ReminderModel) {
        do {
            try realm.write {
                item.isDone.toggle()
            }
        } catch {
            print(error)
        }
    }
    
    // MARK: Delete
    func deleteItem(_ item: ReminderModel) {
        do {
            try realm.write {
                realm.delete(item)
            }
        } catch {
            
        }
    }
}
