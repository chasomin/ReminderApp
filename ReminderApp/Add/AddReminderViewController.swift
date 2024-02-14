//
//  AddReminderViewController.swift
//  ReminderApp
//
//  Created by 차소민 on 2/14/24.
//

import UIKit

class AddReminderViewController: UIViewController {
    
    let mainView = AddReminderView()

    var data: [String:String] = [AddReminderCellList.deadline.rawValue:"", AddReminderCellList.tag.rawValue: "", AddReminderCellList.priority.rawValue: "", AddReminderCellList.image.rawValue: ""] {
        didSet {
            mainView.tableView.reloadData()
        }
    }
    override func loadView() {
        view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setNavigationTitle(title: "새로운 할 일", isLarge: false)
        setNavigationRightBarButton(title: "추가", action: nil)
        setNavigationLeftBarButton(title: "취소", action: #selector(cancelButtonTapped))
        
        let tableView = mainView.tableView
        setTableView(tableView: tableView, delegate: self, dataSource: self, cell: AddReminderTableViewCell.self, id: AddReminderTableViewCell.id)
        tableView.register(AddDetailTableViewCell.self, forCellReuseIdentifier: AddDetailTableViewCell.id)
        
        NotificationCenter.default.addObserver(self, selector: #selector(TagMessageReceivedNotification), name: NSNotification.Name("TagMessage"), object: nil)
    }

    @objc func cancelButtonTapped() {
        dismiss(animated: true)
    }
    
    @objc func TagMessageReceivedNotification(notification: NSNotification) {
        if let value = notification.userInfo?["tag"] as? String {
            data[AddReminderCellList.tag.rawValue] = value
        }
    }
}

extension AddReminderViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        5
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        } else {
            return 1
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: AddReminderTableViewCell.id, for: indexPath) as! AddReminderTableViewCell
            
            if indexPath.row == 0 {
                cell.textField.placeholder = "   제목"
                
            } else {
                cell.textField.placeholder = "   메모"
            }
            
            
            return cell
            
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: AddDetailTableViewCell.id, for: indexPath) as! AddDetailTableViewCell
            cell.configureCell(index: indexPath.section, data: data)
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 50
        } else {
            return 100
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            let vc = DeadlineViewController()
            vc.date = { value in
                self.data[AddReminderCellList.deadline.rawValue] = value
            }
            navigationController?.pushViewController(vc, animated: true)
            
        } else if indexPath.section == 2 {
            navigationController?.pushViewController(TagViewController(), animated: true)
        } else if indexPath.section == 3 {
            let vc = PriorityViewController()
            vc.priorityData = { value in
                self.data[AddReminderCellList.priority.rawValue] = value
            }
            navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.section == 4 {
            navigationController?.pushViewController(ImageViewController(), animated: true)
        }
    }
}
