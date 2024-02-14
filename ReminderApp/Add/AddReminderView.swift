//
//  AddReminderView.swift
//  ReminderApp
//
//  Created by 차소민 on 2/14/24.
//

import UIKit
import SnapKit

class AddReminderView: BaseView {
    
    let tableView = UITableView(frame: .zero, style: .insetGrouped)

    
    override func configureHierarchy() {
        addSubview(tableView)
    }
    
    override func configureLayout() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func configureView() {
        tableView.backgroundColor = .black
        tableView.separatorStyle = .singleLine
        
    }
}
