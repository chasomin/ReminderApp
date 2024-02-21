//
//  RealmNotification.swift
//  ReminderApp
//
//  Created by 차소민 on 2/21/24.
//

import Foundation
import RealmSwift

final class RealmNotification {
    var notificationToken: NotificationToken?
    private let repository = ReminderModelRepository()
    
    private var doInit: (() -> Void)
    private var doUpdate: (() -> Void)
    
    init(doInit: @escaping (() -> Void), doUpdate: @escaping (() -> Void)) {
        self.doInit = doInit
        self.doUpdate = doUpdate
    }
    
    func setNotification() {
        notificationToken = repository.read(type: ReminderBox.self).observe { changes in
            switch changes {
            case .initial(_):
                self.doInit()
                print("===INIT")
            case .update(_, _, _, _):
                print("===UPDATE")
                self.doUpdate()
            case .error(let error):
                print(error)
            }
            
        }

    }
}
