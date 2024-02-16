//
//  ReminderModelRepository.swift
//  ReminderApp
//
//  Created by 차소민 on 2/16/24.
//

import Foundation
import RealmSwift

class ReminderModelRepository {
    let realm = try! Realm()

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
    
    // MARK: Update
//    func updateItem() {
//        do {
//            try realm.write {
//                realm.create(ReminderModel.self, value: <#T##Any#>, update: .modified)
//            }
//        } catch {
//            
//        }
//    }
    
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
