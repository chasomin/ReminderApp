//
//  ReminderListView.swift
//  ReminderApp
//
//  Created by 차소민 on 2/15/24.
//

import UIKit
import SnapKit

class ReminderListView: BaseView {
    let tableView = UITableView()
    
    override func configureHierarchy() {
        addSubview(tableView)
    }
    
    override func configureLayout() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = .black
    }
}
