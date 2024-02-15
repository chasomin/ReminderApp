//
//  AddReminderViewController.swift
//  ReminderApp
//
//  Created by 차소민 on 2/14/24.
//

import UIKit
import RealmSwift

class AddReminderViewController: UIViewController {
    
    let mainView = AddReminderView()

    var data: [String:String] = [AddReminderCellList.deadline.rawValue:"", AddReminderCellList.tag.rawValue: "", AddReminderCellList.priority.rawValue: "", AddReminderCellList.image.rawValue: ""] {
        didSet {
            mainView.tableView.reloadData()
        }
    }
    
    var realmData: ReminderModel = ReminderModel(title: "", memo: "", deadline: "", tag: "", priority: 0)

    var delegate: ReloadDelegate?
    
    var barButton = UIBarButtonItem()

    override func loadView() {
        view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setNavigationTitle(title: "새로운 할 일", isLarge: false)
        setNavigationRightBarButton(button: &barButton, title: "추가", action: #selector(addButtonTapped))
        barButton.isEnabled = false
        
        setNavigationLeftBarButton(title: "취소", action: #selector(cancelButtonTapped))
        
        let tableView = mainView.tableView
        setTableView(tableView: tableView, delegate: self, dataSource: self, cell: AddReminderTitleTableViewCell.self, id: AddReminderTitleTableViewCell.id)
        tableView.register(AddReminderMemoTableViewCell.self, forCellReuseIdentifier: AddReminderMemoTableViewCell.id)
        tableView.register(AddDetailTableViewCell.self, forCellReuseIdentifier: AddDetailTableViewCell.id)
        
        NotificationCenter.default.addObserver(self, selector: #selector(TagMessageReceivedNotification), name: NSNotification.Name("TagMessage"), object: nil)
        
        
    }
    

    @objc func addButtonTapped() {
        let realm = try! Realm()
        print(realm.configuration.fileURL)
        try! realm.write {
            realm.add(realmData)
        }
        delegate?.reload()
        dismiss(animated: true)
    }
    
    
    @objc func cancelButtonTapped() {
        dismiss(animated: true)
    }
    
    @objc func TagMessageReceivedNotification(notification: NSNotification) {
        if let value = notification.userInfo?["tag"] as? String {
            data[AddReminderCellList.tag.rawValue] = value
            realmData.tag = value
            
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
            
            
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: AddReminderTitleTableViewCell.id, for: indexPath) as! AddReminderTitleTableViewCell
                realmData.title = cell.textField.text!
                print(realmData.title)
                
                    
                cell.textField.delegate = self
                return cell
                
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: AddReminderMemoTableViewCell.id, for: indexPath) as! AddReminderMemoTableViewCell

                
                realmData.memo = cell.textView.text
                return cell

            }
            
            
            
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
                self.realmData.deadline = value
            }
            navigationController?.pushViewController(vc, animated: true)
            
        } else if indexPath.section == 2 {
            navigationController?.pushViewController(TagViewController(), animated: true)
        } else if indexPath.section == 3 {
            let vc = PriorityViewController()
            vc.priorityData = { index, text in
                
                self.data[AddReminderCellList.priority.rawValue] = text
                self.realmData.priority = index
            }
            navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.section == 4 {
            navigationController?.pushViewController(ImageViewController(), animated: true)
        }
    }
}

extension AddReminderViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text != "" {
            barButton.isEnabled = true
        } else {
            barButton.isEnabled = false
        }
    }
}
