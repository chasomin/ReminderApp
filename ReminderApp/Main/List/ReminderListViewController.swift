//
//  ReminderListViewController.swift
//  ReminderApp
//
//  Created by 차소민 on 2/15/24.
//

import UIKit
import RealmSwift

final class ReminderListViewController: UIViewController, ReloadDelegate {

    let mainView = ReminderListView()
    var data: Results<ReminderModel>!
    private let repository = ReminderModelRepository()
    var selectedDate: Date?

    override func loadView() {
        view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tableView = mainView.tableView
        setTableView(tableView: tableView, delegate: self, dataSource: self, cell: ReminderListTableViewCell.self, id: ReminderListTableViewCell.id)

        mainView.searchBar.delegate = self
        
        setRightPullDownButton()
    }

    func setRightPullDownButton() {
        let barButton = UIBarButtonItem(image: UIImage(systemName: "ellipsis"),primaryAction: nil)
        let calendarButton = UIBarButtonItem(image: UIImage(systemName: "calendar"), style: .plain, target: self, action: #selector(calendarButtonTapped))
        navigationItem.rightBarButtonItems = [barButton, calendarButton]
        
        let deadline = UIAction(title: "마감일 순") { _ in
            self.data = self.data.sorted(byKeyPath: "deadline", ascending: true)
            self.mainView.tableView.reloadData()
        }
        let title = UIAction(title:"제목 순") { _ in
            self.data = self.data.sorted(byKeyPath: "title", ascending: true)
            self.mainView.tableView.reloadData()
        }
        let priority = UIAction(title: "높은 우선순위만 보기") { _ in
            let saveData = self.data
            self.data = self.data.where {
                $0.priority == 3
            }
            self.mainView.tableView.reloadData()
            self.data = saveData
        }
        barButton.menu = UIMenu(title: "필터",
                                identifier: nil,
                                options: .destructive,
                                children: [deadline, title, priority])
    }
    
    func reload() {
        mainView.tableView.reloadData()
    }

    @objc func isDoneButtonTapped(_ sender: UIButton) {
        repository.updateIsDone(data[sender.tag])
        mainView.tableView.reloadData()
    }
    
    @objc func calendarButtonTapped() {
        print(#function)
        let vc = CalendarViewController()
        vc.calendarData = { value in
            self.data = value
            self.mainView.tableView.reloadData()
        }
    
        vc.selectedDate = { value in
            self.selectedDate = value
        }
        vc.selected = selectedDate
        
        present(vc, animated: true)
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
        if loadImageToDocument(filename: "\(row.id)") == nil {
            cell.image.isHidden = true
        } else {
            cell.image.isHidden = false
            cell.image.image = loadImageToDocument(filename: "\(row.id)")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .normal, title: "삭제") { _, _, _ in
            let row = self.data[indexPath.row]
            self.deleteImageToDocument(filename: "\(row.id)")
            self.repository.deleteItem(row)
            tableView.reloadData()
        }
        delete.backgroundColor = .systemRed
        
        return UISwipeActionsConfiguration(actions:[delete])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = AddReminderViewController(navigationTitle: "할 일 수정", navigationRigthButtonTitle: "수정", barButtonIsEnabled: true, id: data[indexPath.row].id, deleteButtonIsHidden: false)
        vc.delegate = self
        let row = data[indexPath.row]
        vc.realmData = ReminderModel(title: row.title, memo: row.memo, deadline: row.deadline, tag: row.tag, priority: row.priority)
        vc.pickedImage = loadImageToDocument(filename: "\(row.id)") ?? UIImage()
        /// 수정할 때는 row 로 data 그대로 넘기면, 읽으면서 수정하려고 해서 오류남 -> 수정할 때 데이터 따로 삭제할 때 데이터 따로 넘기는 방법 밖에 없나?? // =>  DTO
        vc.deleteData = row
        vc.boxData = data[indexPath.row].box.first ?? ReminderBox(title: "", regDate: Date(), color: 0, icon: 0)
        let nav = UINavigationController(rootViewController: vc)
        present(nav, animated: true)
    }
    
}

extension ReminderListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        data = repository.readFilterSearch(text: searchBar.text!)
        mainView.tableView.reloadData()

        if searchText.isEmpty {
            data = repository.read()
            mainView.tableView.reloadData()
        }
    }
}
