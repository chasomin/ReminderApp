//
//  ReminderListViewController.swift
//  ReminderApp
//
//  Created by 차소민 on 2/15/24.
//

import UIKit
import RealmSwift


class ReminderListViewController: UIViewController {
    
    let mainView = ReminderListView()
    var data: Results<ReminderModel>! {
        didSet {
            mainView.tableView.reloadData()
        }
    }
    let realm = try! Realm()

    override func loadView() {
        view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tableView = mainView.tableView
        setTableView(tableView: tableView, delegate: self, dataSource: self, cell: ReminderListTableViewCell.self, id: ReminderListTableViewCell.id)
        
        receivedReminderData()
        setRightPullDownButton()
    }

    func receivedReminderData() {
        data = realm.objects(ReminderModel.self)
    }
    
    func setRightPullDownButton() {
        let barButton = UIBarButtonItem(image: UIImage(systemName: "ellipsis"),primaryAction: nil)
        navigationItem.rightBarButtonItem = barButton
        
        let deadline = UIAction(title: "마감일 순") { _ in
            self.data = self.realm.objects(ReminderModel.self).sorted(byKeyPath: "deadline", ascending: true)
        }
        let title = UIAction(title:"제목 순") { _ in
            self.data = self.realm.objects(ReminderModel.self).sorted(byKeyPath: "title", ascending: true)
        }
        let priority = UIAction(title: "높은 우선순위만 보기") { _ in
            self.data = self.realm.objects(ReminderModel.self).where {
                $0.priority == 3
            }
        }
        
        barButton.menu = UIMenu(title: "필터",
                                identifier: nil,
                                options: .destructive,
                                children: [deadline, title, priority])
    }
}

extension ReminderListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ReminderListTableViewCell.id, for: indexPath) as! ReminderListTableViewCell
        
        
        let row = data[indexPath.row]
        
        cell.configureCell(data: row)
//        cell.isDoneButton.addTarget(self, action: #selector(isDoneButtonTapped), for: .touchUpInside)
        
        return cell
    }
}
