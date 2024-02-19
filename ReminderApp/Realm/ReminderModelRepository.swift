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
            let start: Date = Calendar.current.startOfDay(for: Date())
            let end: Date = Calendar.current.date(byAdding: .day, value: 1, to: start) ?? Date()
            let predicate = NSPredicate(format: "deadline >= %@ && deadline < %@", start as NSDate, end as NSDate)
            return realm.objects(ReminderModel.self).filter(predicate)
        case .schedule:
            let start: Date = Date()
            let predicate = NSPredicate(format: "deadline > %@", start as NSDate)
            return realm.objects(ReminderModel.self).filter(predicate)
        case .all:
            return realm.objects(ReminderModel.self)
        case .flag:
            return realm.objects(ReminderModel.self)// TODO: ///
        case .done:
            return realm.objects(ReminderModel.self).where {
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
    func updateItem(id: ObjectId, title: String, memo: String?, deadline: Date, tag: String?, priority: Int) {
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
