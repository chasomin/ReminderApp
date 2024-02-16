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
            mainView.tableView.reloadData() //???: 필터엔 왜 잘 되지
        }
    }
    let repository = ReminderModelRepository()

    override func loadView() {
        view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tableView = mainView.tableView
        setTableView(tableView: tableView, delegate: self, dataSource: self, cell: ReminderListTableViewCell.self, id: ReminderListTableViewCell.id)
        
        data = repository.read()
        
        setRightPullDownButton()
    }

    func setRightPullDownButton() {
        let barButton = UIBarButtonItem(image: UIImage(systemName: "ellipsis"),primaryAction: nil)
        navigationItem.rightBarButtonItem = barButton
        
        let deadline = UIAction(title: "마감일 순") { _ in
            self.data = self.repository.readDeadlineSort()
        }
        let title = UIAction(title:"제목 순") { _ in
            self.data = self.repository.readTitleSort()
        }
        let priority = UIAction(title: "높은 우선순위만 보기") { _ in
            self.data = self.repository.readPriorityFilter()
        }
        barButton.menu = UIMenu(title: "필터",
                                identifier: nil,
                                options: .destructive,
                                children: [deadline, title, priority])
    }
    @objc func isDoneButtonTapped(_ sender: UIButton) {
        print("체크")
        //update
        repository.updateIsDone(data[sender.tag])
        mainView.tableView.reloadData()
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
        cell.isDoneButton.tag = indexPath.row
        cell.isDoneButton.addTarget(self, action: #selector(isDoneButtonTapped), for: .touchUpInside)

        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .normal, title: "삭제") { (_, _, success: @escaping (Bool) -> Void) in
            print("삭제 클릭 됨")
            self.repository.deleteItem(self.data[indexPath.row])
            tableView.reloadData()
            success(true)
        }
        delete.backgroundColor = .systemRed
        
        return UISwipeActionsConfiguration(actions:[delete])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 수정 뷰 이동 -> Realm Update, Realm Delete
    }
    
}

