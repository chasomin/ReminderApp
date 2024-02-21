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
    func createItem<T: Object>(_ item: T, type: T.Type = T.self) {
        do {
            try realm.write {
                realm.add(item)
            }
        } catch {
            print(error)
        }
    }
    
    func appendItme<T: Object>(_ item: T, data: List<T>) {
        do {
            try realm.write {
                data.append(item)
            }
        } catch {
            
        }
    }
    
    // MARK: Read
    func read<T: Object>(type: T.Type = T.self) -> Results<T> {
        realm.objects(type)
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
            print(error)
        }
    }
    
    func createLinkingObjects<T: Object>(new: List<T>, data: T) {
        do {
            try realm.write {
                new.append(data)
            }
        } catch {
            print(error)
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
    func deleteItem<T: Object>(_ item: T) {
        do {
            try realm.write {
                realm.delete(item)
            }
        } catch {
            
        }
    }
    
    func deleteList<T: Object>(_ list: List<T>) {
        do {
            try realm.write {
                realm.delete(list)
            }
        } catch {
            
        }
    }
    
    
    func deleteLinkingObjects(old: List<ReminderModel>, id: ObjectId) {
        do {
            try realm.write {
                
                let deleteItem = old.where {
                    return $0.id == id
                }.first

                guard let deleteItem else{return}
                
                realm.delete(deleteItem)
            }
        } catch {
            
        }
    }
}
